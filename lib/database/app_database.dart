import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:newspaper_calculator_app/models/monthly_payment.dart';

part 'app_database.g.dart';

enum Status { received, skipped }

class Newspapers extends Table {
  @override
  String get tableName => 'newspaper';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get weekdayPrice => real()();
  RealColumn get weekendPrice => real()();
  BoolColumn get isActive => boolean().clientDefault(() => false)();
}

class Payments extends Table {
  @override
  String get tableName => 'payment';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get newspaperId =>
      integer().references(Newspapers, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get billingMonth => dateTime()();
  RealColumn get amountPaid => real()();
  DateTimeColumn get paidOn => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {newspaperId, billingMonth},
  ];
}

class DeliveryEntries extends Table {
  @override
  String get tableName => 'deliveryEntries';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get newspaperId =>
      integer().references(Newspapers, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get deliveryDate => dateTime()();
  TextColumn get status => textEnum<Status>()();
  RealColumn get price => real()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {newspaperId, deliveryDate},
  ];
}

@DriftDatabase(tables: [Newspapers, Payments, DeliveryEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'newspaper_calculator'));

  Future<int> addNewspaper({
    required String name,
    required double weekdayPrice,
    required double weekendPrice,
    required bool isActive,
  }) {
    return into(newspapers).insert(
      NewspapersCompanion.insert(
        name: name,
        weekdayPrice: weekdayPrice,
        weekendPrice: weekendPrice,
        isActive: Value(isActive),
      ),
    );
  }

  Future<void> updateNewspaper({
    required int id,
    required String name,
    required double weekdayPrice,
    required double weekendPrice,
    required bool isActive,
  }) {
    return (update(newspapers)..where((n) => n.id.equals(id))).write(
      NewspapersCompanion(
        name: Value(name),
        weekdayPrice: Value(weekdayPrice),
        weekendPrice: Value(weekendPrice),
        isActive: Value(isActive),
      ),
    );
  }

  Stream<List<Newspaper>> watchNewspapers() {
    return (select(
      newspapers,
    )..orderBy([(newspaper) => OrderingTerm.asc(newspaper.name)])).watch();
  }

  Stream<List<Newspaper>> watchActiveNewspapers() {
    return (select(newspapers)
          ..where((n) => n.isActive.equals(true))
          ..orderBy([(newspaper) => OrderingTerm.asc(newspaper.name)]))
        .watch();
  }

  Stream<List<MonthlyPayment>> watchMonthlyPaymentHistory() {
    return customSelect(
      'SELECT 1',
      readsFrom: {deliveryEntries, payments},
    ).watch().asyncMap((_) async {
      final deliveryRows = await (select(
        deliveryEntries,
      )..where((entry) => entry.status.equalsValue(Status.received))).get();
      final paymentRows = await select(payments).get();
      final grouped = <DateTime, MonthlyPayment>{};
      final receivedDates = <DateTime, Set<DateTime>>{};

      for (final delivery in deliveryRows) {
        final month = DateTime(
          delivery.deliveryDate.year,
          delivery.deliveryDate.month,
        );
        final existing = grouped[month];
        final dates = receivedDates.putIfAbsent(month, () => <DateTime>{});
        dates.add(
          DateTime(
            delivery.deliveryDate.year,
            delivery.deliveryDate.month,
            delivery.deliveryDate.day,
          ),
        );

        grouped[month] = MonthlyPayment(
          billingMonth: month,
          amount: (existing?.amount ?? 0) + delivery.price,
          amountPaid: existing?.amountPaid ?? 0,
          paidOn: existing?.paidOn,
          paymentCount: existing?.paymentCount ?? 0,
          receivedDays: dates.length,
        );
      }

      for (final payment in paymentRows) {
        final month = DateTime(
          payment.billingMonth.year,
          payment.billingMonth.month,
        );
        final existing = grouped[month];
        if (existing == null) continue;

        grouped[month] = MonthlyPayment(
          billingMonth: month,
          amount: existing.amount,
          amountPaid: existing.amountPaid + payment.amountPaid,
          paidOn:
              existing.paidOn == null ||
                  payment.paidOn.isAfter(existing.paidOn!)
              ? payment.paidOn
              : existing.paidOn,
          paymentCount: existing.paymentCount + 1,
          receivedDays: existing.receivedDays,
        );
      }

      final history = grouped.values.toList();
      history.sort((a, b) => b.billingMonth.compareTo(a.billingMonth));
      return history;
    });
  }

  Future<void> settleMonth(DateTime billingMonth) async {
    final month = DateTime(billingMonth.year, billingMonth.month);
    final nextMonth = DateTime(billingMonth.year, billingMonth.month + 1);
    final entries =
        await (select(deliveryEntries)..where(
              (entry) =>
                  entry.deliveryDate.isBiggerOrEqualValue(month) &
                  entry.deliveryDate.isSmallerThanValue(nextMonth) &
                  entry.status.equalsValue(Status.received),
            ))
            .get();

    final totalsByNewspaper = <int, double>{};
    for (final entry in entries) {
      totalsByNewspaper.update(
        entry.newspaperId,
        (amount) => amount + entry.price,
        ifAbsent: () => entry.price,
      );
    }

    await transaction(() async {
      for (final entry in totalsByNewspaper.entries) {
        await into(payments).insertOnConflictUpdate(
          PaymentsCompanion.insert(
            newspaperId: entry.key,
            billingMonth: month,
            amountPaid: entry.value,
            paidOn: DateTime.now(),
          ),
        );
      }
    });
  }

  Future<void> removeNewspaper(int newspaperId) {
    return (delete(newspapers)..where((n) => n.id.equals(newspaperId))).go();
  }

  Future<int> addDailyDeliveryEntry({
    required int newspaperId,
    required Status status,
    required double price,
  }) {
    final today = DateTime.now();

    final deliveryDate = DateTime(today.year, today.month, today.day);

    return into(deliveryEntries).insertOnConflictUpdate(
      DeliveryEntriesCompanion.insert(
        newspaperId: newspaperId,
        deliveryDate: deliveryDate,
        status: status,
        price: price,
      ),
    );
  }

  Future<double> getAmountGeneratedUntilToday() async {
    final today = DateTime.now();
    final startOfMonth = DateTime(today.year, today.month, 1);
    final startOfTomorrow = DateTime(today.year, today.month, today.day + 1);

    final totalPrice = deliveryEntries.price.sum();

    final query = selectOnly(deliveryEntries)
      ..addColumns([totalPrice])
      ..where(
        deliveryEntries.deliveryDate.isBiggerOrEqualValue(startOfMonth) &
            deliveryEntries.deliveryDate.isSmallerThanValue(startOfTomorrow) &
            deliveryEntries.status.equalsValue(Status.received),
      );
    final row = await query.getSingle();
    return row.read(totalPrice) ?? 0.0;
  }

  Future<Set<int>> getLoggedNewspaperIdsForToday() async {
    final today = DateTime.now();
    final startOfToday = DateTime(today.year, today.month, today.day);
    final startOfTomorrow = DateTime(today.year, today.month, today.day + 1);

    final query = select(deliveryEntries)
      ..where(
        (entry) =>
            entry.deliveryDate.isBiggerOrEqualValue(startOfToday) &
            entry.deliveryDate.isSmallerThanValue(startOfTomorrow),
      );

    final rows = await query.get();
    return rows.map((entry) => entry.newspaperId).toSet();
  }

  Stream<Set<DateTime>> watchLoggedDeliveryDatesForCurrentMonth() {
    final today = DateTime.now();
    final startOfMonth = DateTime(today.year, today.month, 1);
    final startOfNextMonth = DateTime(today.year, today.month + 1, 1);

    final query = select(deliveryEntries)
      ..where(
        (entry) =>
            entry.deliveryDate.isBiggerOrEqualValue(startOfMonth) &
            entry.deliveryDate.isSmallerThanValue(startOfNextMonth),
      );

    return query.watch().map(
      (entries) => entries
          .map(
            (entry) => DateTime(
              entry.deliveryDate.year,
              entry.deliveryDate.month,
              entry.deliveryDate.day,
            ),
          )
          .toSet(),
    );
  }

  @override
  int get schemaVersion => 1;
}
