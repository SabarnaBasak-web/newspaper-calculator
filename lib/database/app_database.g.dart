// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $NewspapersTable extends Newspapers
    with TableInfo<$NewspapersTable, Newspaper> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewspapersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekdayPriceMeta = const VerificationMeta(
    'weekdayPrice',
  );
  @override
  late final GeneratedColumn<double> weekdayPrice = GeneratedColumn<double>(
    'weekday_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekendPriceMeta = const VerificationMeta(
    'weekendPrice',
  );
  @override
  late final GeneratedColumn<double> weekendPrice = GeneratedColumn<double>(
    'weekend_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    clientDefault: () => false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    weekdayPrice,
    weekendPrice,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'newspaper';
  @override
  VerificationContext validateIntegrity(
    Insertable<Newspaper> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('weekday_price')) {
      context.handle(
        _weekdayPriceMeta,
        weekdayPrice.isAcceptableOrUnknown(
          data['weekday_price']!,
          _weekdayPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weekdayPriceMeta);
    }
    if (data.containsKey('weekend_price')) {
      context.handle(
        _weekendPriceMeta,
        weekendPrice.isAcceptableOrUnknown(
          data['weekend_price']!,
          _weekendPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weekendPriceMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Newspaper map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Newspaper(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      weekdayPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weekday_price'],
      )!,
      weekendPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weekend_price'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $NewspapersTable createAlias(String alias) {
    return $NewspapersTable(attachedDatabase, alias);
  }
}

class Newspaper extends DataClass implements Insertable<Newspaper> {
  final int id;
  final String name;
  final double weekdayPrice;
  final double weekendPrice;
  final bool isActive;
  const Newspaper({
    required this.id,
    required this.name,
    required this.weekdayPrice,
    required this.weekendPrice,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['weekday_price'] = Variable<double>(weekdayPrice);
    map['weekend_price'] = Variable<double>(weekendPrice);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  NewspapersCompanion toCompanion(bool nullToAbsent) {
    return NewspapersCompanion(
      id: Value(id),
      name: Value(name),
      weekdayPrice: Value(weekdayPrice),
      weekendPrice: Value(weekendPrice),
      isActive: Value(isActive),
    );
  }

  factory Newspaper.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Newspaper(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      weekdayPrice: serializer.fromJson<double>(json['weekdayPrice']),
      weekendPrice: serializer.fromJson<double>(json['weekendPrice']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'weekdayPrice': serializer.toJson<double>(weekdayPrice),
      'weekendPrice': serializer.toJson<double>(weekendPrice),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Newspaper copyWith({
    int? id,
    String? name,
    double? weekdayPrice,
    double? weekendPrice,
    bool? isActive,
  }) => Newspaper(
    id: id ?? this.id,
    name: name ?? this.name,
    weekdayPrice: weekdayPrice ?? this.weekdayPrice,
    weekendPrice: weekendPrice ?? this.weekendPrice,
    isActive: isActive ?? this.isActive,
  );
  Newspaper copyWithCompanion(NewspapersCompanion data) {
    return Newspaper(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      weekdayPrice: data.weekdayPrice.present
          ? data.weekdayPrice.value
          : this.weekdayPrice,
      weekendPrice: data.weekendPrice.present
          ? data.weekendPrice.value
          : this.weekendPrice,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Newspaper(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('weekdayPrice: $weekdayPrice, ')
          ..write('weekendPrice: $weekendPrice, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, weekdayPrice, weekendPrice, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Newspaper &&
          other.id == this.id &&
          other.name == this.name &&
          other.weekdayPrice == this.weekdayPrice &&
          other.weekendPrice == this.weekendPrice &&
          other.isActive == this.isActive);
}

class NewspapersCompanion extends UpdateCompanion<Newspaper> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> weekdayPrice;
  final Value<double> weekendPrice;
  final Value<bool> isActive;
  const NewspapersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.weekdayPrice = const Value.absent(),
    this.weekendPrice = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  NewspapersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double weekdayPrice,
    required double weekendPrice,
    this.isActive = const Value.absent(),
  }) : name = Value(name),
       weekdayPrice = Value(weekdayPrice),
       weekendPrice = Value(weekendPrice);
  static Insertable<Newspaper> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? weekdayPrice,
    Expression<double>? weekendPrice,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (weekdayPrice != null) 'weekday_price': weekdayPrice,
      if (weekendPrice != null) 'weekend_price': weekendPrice,
      if (isActive != null) 'is_active': isActive,
    });
  }

  NewspapersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double>? weekdayPrice,
    Value<double>? weekendPrice,
    Value<bool>? isActive,
  }) {
    return NewspapersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      weekdayPrice: weekdayPrice ?? this.weekdayPrice,
      weekendPrice: weekendPrice ?? this.weekendPrice,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (weekdayPrice.present) {
      map['weekday_price'] = Variable<double>(weekdayPrice.value);
    }
    if (weekendPrice.present) {
      map['weekend_price'] = Variable<double>(weekendPrice.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewspapersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('weekdayPrice: $weekdayPrice, ')
          ..write('weekendPrice: $weekendPrice, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _newspaperIdMeta = const VerificationMeta(
    'newspaperId',
  );
  @override
  late final GeneratedColumn<int> newspaperId = GeneratedColumn<int>(
    'newspaper_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES newspaper (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _billingMonthMeta = const VerificationMeta(
    'billingMonth',
  );
  @override
  late final GeneratedColumn<DateTime> billingMonth = GeneratedColumn<DateTime>(
    'billing_month',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountPaidMeta = const VerificationMeta(
    'amountPaid',
  );
  @override
  late final GeneratedColumn<double> amountPaid = GeneratedColumn<double>(
    'amount_paid',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidOnMeta = const VerificationMeta('paidOn');
  @override
  late final GeneratedColumn<DateTime> paidOn = GeneratedColumn<DateTime>(
    'paid_on',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    newspaperId,
    billingMonth,
    amountPaid,
    paidOn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment';
  @override
  VerificationContext validateIntegrity(
    Insertable<Payment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('newspaper_id')) {
      context.handle(
        _newspaperIdMeta,
        newspaperId.isAcceptableOrUnknown(
          data['newspaper_id']!,
          _newspaperIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_newspaperIdMeta);
    }
    if (data.containsKey('billing_month')) {
      context.handle(
        _billingMonthMeta,
        billingMonth.isAcceptableOrUnknown(
          data['billing_month']!,
          _billingMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_billingMonthMeta);
    }
    if (data.containsKey('amount_paid')) {
      context.handle(
        _amountPaidMeta,
        amountPaid.isAcceptableOrUnknown(data['amount_paid']!, _amountPaidMeta),
      );
    } else if (isInserting) {
      context.missing(_amountPaidMeta);
    }
    if (data.containsKey('paid_on')) {
      context.handle(
        _paidOnMeta,
        paidOn.isAcceptableOrUnknown(data['paid_on']!, _paidOnMeta),
      );
    } else if (isInserting) {
      context.missing(_paidOnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {newspaperId, billingMonth},
  ];
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      newspaperId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}newspaper_id'],
      )!,
      billingMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}billing_month'],
      )!,
      amountPaid: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount_paid'],
      )!,
      paidOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_on'],
      )!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  final int id;
  final int newspaperId;
  final DateTime billingMonth;
  final double amountPaid;
  final DateTime paidOn;
  const Payment({
    required this.id,
    required this.newspaperId,
    required this.billingMonth,
    required this.amountPaid,
    required this.paidOn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['newspaper_id'] = Variable<int>(newspaperId);
    map['billing_month'] = Variable<DateTime>(billingMonth);
    map['amount_paid'] = Variable<double>(amountPaid);
    map['paid_on'] = Variable<DateTime>(paidOn);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      newspaperId: Value(newspaperId),
      billingMonth: Value(billingMonth),
      amountPaid: Value(amountPaid),
      paidOn: Value(paidOn),
    );
  }

  factory Payment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<int>(json['id']),
      newspaperId: serializer.fromJson<int>(json['newspaperId']),
      billingMonth: serializer.fromJson<DateTime>(json['billingMonth']),
      amountPaid: serializer.fromJson<double>(json['amountPaid']),
      paidOn: serializer.fromJson<DateTime>(json['paidOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'newspaperId': serializer.toJson<int>(newspaperId),
      'billingMonth': serializer.toJson<DateTime>(billingMonth),
      'amountPaid': serializer.toJson<double>(amountPaid),
      'paidOn': serializer.toJson<DateTime>(paidOn),
    };
  }

  Payment copyWith({
    int? id,
    int? newspaperId,
    DateTime? billingMonth,
    double? amountPaid,
    DateTime? paidOn,
  }) => Payment(
    id: id ?? this.id,
    newspaperId: newspaperId ?? this.newspaperId,
    billingMonth: billingMonth ?? this.billingMonth,
    amountPaid: amountPaid ?? this.amountPaid,
    paidOn: paidOn ?? this.paidOn,
  );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      newspaperId: data.newspaperId.present
          ? data.newspaperId.value
          : this.newspaperId,
      billingMonth: data.billingMonth.present
          ? data.billingMonth.value
          : this.billingMonth,
      amountPaid: data.amountPaid.present
          ? data.amountPaid.value
          : this.amountPaid,
      paidOn: data.paidOn.present ? data.paidOn.value : this.paidOn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('newspaperId: $newspaperId, ')
          ..write('billingMonth: $billingMonth, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('paidOn: $paidOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, newspaperId, billingMonth, amountPaid, paidOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.newspaperId == this.newspaperId &&
          other.billingMonth == this.billingMonth &&
          other.amountPaid == this.amountPaid &&
          other.paidOn == this.paidOn);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<int> id;
  final Value<int> newspaperId;
  final Value<DateTime> billingMonth;
  final Value<double> amountPaid;
  final Value<DateTime> paidOn;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.newspaperId = const Value.absent(),
    this.billingMonth = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.paidOn = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int newspaperId,
    required DateTime billingMonth,
    required double amountPaid,
    required DateTime paidOn,
  }) : newspaperId = Value(newspaperId),
       billingMonth = Value(billingMonth),
       amountPaid = Value(amountPaid),
       paidOn = Value(paidOn);
  static Insertable<Payment> custom({
    Expression<int>? id,
    Expression<int>? newspaperId,
    Expression<DateTime>? billingMonth,
    Expression<double>? amountPaid,
    Expression<DateTime>? paidOn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (newspaperId != null) 'newspaper_id': newspaperId,
      if (billingMonth != null) 'billing_month': billingMonth,
      if (amountPaid != null) 'amount_paid': amountPaid,
      if (paidOn != null) 'paid_on': paidOn,
    });
  }

  PaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? newspaperId,
    Value<DateTime>? billingMonth,
    Value<double>? amountPaid,
    Value<DateTime>? paidOn,
  }) {
    return PaymentsCompanion(
      id: id ?? this.id,
      newspaperId: newspaperId ?? this.newspaperId,
      billingMonth: billingMonth ?? this.billingMonth,
      amountPaid: amountPaid ?? this.amountPaid,
      paidOn: paidOn ?? this.paidOn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (newspaperId.present) {
      map['newspaper_id'] = Variable<int>(newspaperId.value);
    }
    if (billingMonth.present) {
      map['billing_month'] = Variable<DateTime>(billingMonth.value);
    }
    if (amountPaid.present) {
      map['amount_paid'] = Variable<double>(amountPaid.value);
    }
    if (paidOn.present) {
      map['paid_on'] = Variable<DateTime>(paidOn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('newspaperId: $newspaperId, ')
          ..write('billingMonth: $billingMonth, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('paidOn: $paidOn')
          ..write(')'))
        .toString();
  }
}

class $DeliveryEntriesTable extends DeliveryEntries
    with TableInfo<$DeliveryEntriesTable, DeliveryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeliveryEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _newspaperIdMeta = const VerificationMeta(
    'newspaperId',
  );
  @override
  late final GeneratedColumn<int> newspaperId = GeneratedColumn<int>(
    'newspaper_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES newspaper (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _deliveryDateMeta = const VerificationMeta(
    'deliveryDate',
  );
  @override
  late final GeneratedColumn<DateTime> deliveryDate = GeneratedColumn<DateTime>(
    'delivery_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Status, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Status>($DeliveryEntriesTable.$converterstatus);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    newspaperId,
    deliveryDate,
    status,
    price,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'deliveryEntries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeliveryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('newspaper_id')) {
      context.handle(
        _newspaperIdMeta,
        newspaperId.isAcceptableOrUnknown(
          data['newspaper_id']!,
          _newspaperIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_newspaperIdMeta);
    }
    if (data.containsKey('delivery_date')) {
      context.handle(
        _deliveryDateMeta,
        deliveryDate.isAcceptableOrUnknown(
          data['delivery_date']!,
          _deliveryDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deliveryDateMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {newspaperId, deliveryDate},
  ];
  @override
  DeliveryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeliveryEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      newspaperId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}newspaper_id'],
      )!,
      deliveryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}delivery_date'],
      )!,
      status: $DeliveryEntriesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
    );
  }

  @override
  $DeliveryEntriesTable createAlias(String alias) {
    return $DeliveryEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Status, String, String> $converterstatus =
      const EnumNameConverter<Status>(Status.values);
}

class DeliveryEntry extends DataClass implements Insertable<DeliveryEntry> {
  final int id;
  final int newspaperId;
  final DateTime deliveryDate;
  final Status status;
  final double price;
  const DeliveryEntry({
    required this.id,
    required this.newspaperId,
    required this.deliveryDate,
    required this.status,
    required this.price,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['newspaper_id'] = Variable<int>(newspaperId);
    map['delivery_date'] = Variable<DateTime>(deliveryDate);
    {
      map['status'] = Variable<String>(
        $DeliveryEntriesTable.$converterstatus.toSql(status),
      );
    }
    map['price'] = Variable<double>(price);
    return map;
  }

  DeliveryEntriesCompanion toCompanion(bool nullToAbsent) {
    return DeliveryEntriesCompanion(
      id: Value(id),
      newspaperId: Value(newspaperId),
      deliveryDate: Value(deliveryDate),
      status: Value(status),
      price: Value(price),
    );
  }

  factory DeliveryEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeliveryEntry(
      id: serializer.fromJson<int>(json['id']),
      newspaperId: serializer.fromJson<int>(json['newspaperId']),
      deliveryDate: serializer.fromJson<DateTime>(json['deliveryDate']),
      status: $DeliveryEntriesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      price: serializer.fromJson<double>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'newspaperId': serializer.toJson<int>(newspaperId),
      'deliveryDate': serializer.toJson<DateTime>(deliveryDate),
      'status': serializer.toJson<String>(
        $DeliveryEntriesTable.$converterstatus.toJson(status),
      ),
      'price': serializer.toJson<double>(price),
    };
  }

  DeliveryEntry copyWith({
    int? id,
    int? newspaperId,
    DateTime? deliveryDate,
    Status? status,
    double? price,
  }) => DeliveryEntry(
    id: id ?? this.id,
    newspaperId: newspaperId ?? this.newspaperId,
    deliveryDate: deliveryDate ?? this.deliveryDate,
    status: status ?? this.status,
    price: price ?? this.price,
  );
  DeliveryEntry copyWithCompanion(DeliveryEntriesCompanion data) {
    return DeliveryEntry(
      id: data.id.present ? data.id.value : this.id,
      newspaperId: data.newspaperId.present
          ? data.newspaperId.value
          : this.newspaperId,
      deliveryDate: data.deliveryDate.present
          ? data.deliveryDate.value
          : this.deliveryDate,
      status: data.status.present ? data.status.value : this.status,
      price: data.price.present ? data.price.value : this.price,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeliveryEntry(')
          ..write('id: $id, ')
          ..write('newspaperId: $newspaperId, ')
          ..write('deliveryDate: $deliveryDate, ')
          ..write('status: $status, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, newspaperId, deliveryDate, status, price);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeliveryEntry &&
          other.id == this.id &&
          other.newspaperId == this.newspaperId &&
          other.deliveryDate == this.deliveryDate &&
          other.status == this.status &&
          other.price == this.price);
}

class DeliveryEntriesCompanion extends UpdateCompanion<DeliveryEntry> {
  final Value<int> id;
  final Value<int> newspaperId;
  final Value<DateTime> deliveryDate;
  final Value<Status> status;
  final Value<double> price;
  const DeliveryEntriesCompanion({
    this.id = const Value.absent(),
    this.newspaperId = const Value.absent(),
    this.deliveryDate = const Value.absent(),
    this.status = const Value.absent(),
    this.price = const Value.absent(),
  });
  DeliveryEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int newspaperId,
    required DateTime deliveryDate,
    required Status status,
    required double price,
  }) : newspaperId = Value(newspaperId),
       deliveryDate = Value(deliveryDate),
       status = Value(status),
       price = Value(price);
  static Insertable<DeliveryEntry> custom({
    Expression<int>? id,
    Expression<int>? newspaperId,
    Expression<DateTime>? deliveryDate,
    Expression<String>? status,
    Expression<double>? price,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (newspaperId != null) 'newspaper_id': newspaperId,
      if (deliveryDate != null) 'delivery_date': deliveryDate,
      if (status != null) 'status': status,
      if (price != null) 'price': price,
    });
  }

  DeliveryEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? newspaperId,
    Value<DateTime>? deliveryDate,
    Value<Status>? status,
    Value<double>? price,
  }) {
    return DeliveryEntriesCompanion(
      id: id ?? this.id,
      newspaperId: newspaperId ?? this.newspaperId,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      status: status ?? this.status,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (newspaperId.present) {
      map['newspaper_id'] = Variable<int>(newspaperId.value);
    }
    if (deliveryDate.present) {
      map['delivery_date'] = Variable<DateTime>(deliveryDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $DeliveryEntriesTable.$converterstatus.toSql(status.value),
      );
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeliveryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('newspaperId: $newspaperId, ')
          ..write('deliveryDate: $deliveryDate, ')
          ..write('status: $status, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NewspapersTable newspapers = $NewspapersTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $DeliveryEntriesTable deliveryEntries = $DeliveryEntriesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    newspapers,
    payments,
    deliveryEntries,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'newspaper',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('payment', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'newspaper',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('deliveryEntries', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$NewspapersTableCreateCompanionBuilder =
    NewspapersCompanion Function({
      Value<int> id,
      required String name,
      required double weekdayPrice,
      required double weekendPrice,
      Value<bool> isActive,
    });
typedef $$NewspapersTableUpdateCompanionBuilder =
    NewspapersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<double> weekdayPrice,
      Value<double> weekendPrice,
      Value<bool> isActive,
    });

final class $$NewspapersTableReferences
    extends BaseReferences<_$AppDatabase, $NewspapersTable, Newspaper> {
  $$NewspapersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: 'newspaper__id__payment__newspaper_id',
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.newspaperId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DeliveryEntriesTable, List<DeliveryEntry>>
  _deliveryEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.deliveryEntries,
    aliasName: 'newspaper__id__deliveryEntries__newspaper_id',
  );

  $$DeliveryEntriesTableProcessedTableManager get deliveryEntriesRefs {
    final manager = $$DeliveryEntriesTableTableManager(
      $_db,
      $_db.deliveryEntries,
    ).filter((f) => f.newspaperId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _deliveryEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$NewspapersTableFilterComposer
    extends Composer<_$AppDatabase, $NewspapersTable> {
  $$NewspapersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weekdayPrice => $composableBuilder(
    column: $table.weekdayPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weekendPrice => $composableBuilder(
    column: $table.weekendPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.newspaperId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> deliveryEntriesRefs(
    Expression<bool> Function($$DeliveryEntriesTableFilterComposer f) f,
  ) {
    final $$DeliveryEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deliveryEntries,
      getReferencedColumn: (t) => t.newspaperId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeliveryEntriesTableFilterComposer(
            $db: $db,
            $table: $db.deliveryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NewspapersTableOrderingComposer
    extends Composer<_$AppDatabase, $NewspapersTable> {
  $$NewspapersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weekdayPrice => $composableBuilder(
    column: $table.weekdayPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weekendPrice => $composableBuilder(
    column: $table.weekendPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NewspapersTableAnnotationComposer
    extends Composer<_$AppDatabase, $NewspapersTable> {
  $$NewspapersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get weekdayPrice => $composableBuilder(
    column: $table.weekdayPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weekendPrice => $composableBuilder(
    column: $table.weekendPrice,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.newspaperId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> deliveryEntriesRefs<T extends Object>(
    Expression<T> Function($$DeliveryEntriesTableAnnotationComposer a) f,
  ) {
    final $$DeliveryEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deliveryEntries,
      getReferencedColumn: (t) => t.newspaperId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeliveryEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.deliveryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NewspapersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NewspapersTable,
          Newspaper,
          $$NewspapersTableFilterComposer,
          $$NewspapersTableOrderingComposer,
          $$NewspapersTableAnnotationComposer,
          $$NewspapersTableCreateCompanionBuilder,
          $$NewspapersTableUpdateCompanionBuilder,
          (Newspaper, $$NewspapersTableReferences),
          Newspaper,
          PrefetchHooks Function({bool paymentsRefs, bool deliveryEntriesRefs})
        > {
  $$NewspapersTableTableManager(_$AppDatabase db, $NewspapersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NewspapersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NewspapersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NewspapersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> weekdayPrice = const Value.absent(),
                Value<double> weekendPrice = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => NewspapersCompanion(
                id: id,
                name: name,
                weekdayPrice: weekdayPrice,
                weekendPrice: weekendPrice,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required double weekdayPrice,
                required double weekendPrice,
                Value<bool> isActive = const Value.absent(),
              }) => NewspapersCompanion.insert(
                id: id,
                name: name,
                weekdayPrice: weekdayPrice,
                weekendPrice: weekendPrice,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NewspapersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({paymentsRefs = false, deliveryEntriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (paymentsRefs) db.payments,
                    if (deliveryEntriesRefs) db.deliveryEntries,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (paymentsRefs)
                        await $_getPrefetchedData<
                          Newspaper,
                          $NewspapersTable,
                          Payment
                        >(
                          currentTable: table,
                          referencedTable: $$NewspapersTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$NewspapersTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.newspaperId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (deliveryEntriesRefs)
                        await $_getPrefetchedData<
                          Newspaper,
                          $NewspapersTable,
                          DeliveryEntry
                        >(
                          currentTable: table,
                          referencedTable: $$NewspapersTableReferences
                              ._deliveryEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$NewspapersTableReferences(
                                db,
                                table,
                                p0,
                              ).deliveryEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.newspaperId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$NewspapersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NewspapersTable,
      Newspaper,
      $$NewspapersTableFilterComposer,
      $$NewspapersTableOrderingComposer,
      $$NewspapersTableAnnotationComposer,
      $$NewspapersTableCreateCompanionBuilder,
      $$NewspapersTableUpdateCompanionBuilder,
      (Newspaper, $$NewspapersTableReferences),
      Newspaper,
      PrefetchHooks Function({bool paymentsRefs, bool deliveryEntriesRefs})
    >;
typedef $$PaymentsTableCreateCompanionBuilder =
    PaymentsCompanion Function({
      Value<int> id,
      required int newspaperId,
      required DateTime billingMonth,
      required double amountPaid,
      required DateTime paidOn,
    });
typedef $$PaymentsTableUpdateCompanionBuilder =
    PaymentsCompanion Function({
      Value<int> id,
      Value<int> newspaperId,
      Value<DateTime> billingMonth,
      Value<double> amountPaid,
      Value<DateTime> paidOn,
    });

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, Payment> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $NewspapersTable _newspaperIdTable(_$AppDatabase db) =>
      db.newspapers.createAlias('payment__newspaper_id__newspaper__id');

  $$NewspapersTableProcessedTableManager get newspaperId {
    final $_column = $_itemColumn<int>('newspaper_id')!;

    final manager = $$NewspapersTableTableManager(
      $_db,
      $_db.newspapers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_newspaperIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get billingMonth => $composableBuilder(
    column: $table.billingMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidOn => $composableBuilder(
    column: $table.paidOn,
    builder: (column) => ColumnFilters(column),
  );

  $$NewspapersTableFilterComposer get newspaperId {
    final $$NewspapersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.newspaperId,
      referencedTable: $db.newspapers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NewspapersTableFilterComposer(
            $db: $db,
            $table: $db.newspapers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get billingMonth => $composableBuilder(
    column: $table.billingMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidOn => $composableBuilder(
    column: $table.paidOn,
    builder: (column) => ColumnOrderings(column),
  );

  $$NewspapersTableOrderingComposer get newspaperId {
    final $$NewspapersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.newspaperId,
      referencedTable: $db.newspapers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NewspapersTableOrderingComposer(
            $db: $db,
            $table: $db.newspapers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get billingMonth => $composableBuilder(
    column: $table.billingMonth,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get paidOn =>
      $composableBuilder(column: $table.paidOn, builder: (column) => column);

  $$NewspapersTableAnnotationComposer get newspaperId {
    final $$NewspapersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.newspaperId,
      referencedTable: $db.newspapers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NewspapersTableAnnotationComposer(
            $db: $db,
            $table: $db.newspapers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          Payment,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (Payment, $$PaymentsTableReferences),
          Payment,
          PrefetchHooks Function({bool newspaperId})
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> newspaperId = const Value.absent(),
                Value<DateTime> billingMonth = const Value.absent(),
                Value<double> amountPaid = const Value.absent(),
                Value<DateTime> paidOn = const Value.absent(),
              }) => PaymentsCompanion(
                id: id,
                newspaperId: newspaperId,
                billingMonth: billingMonth,
                amountPaid: amountPaid,
                paidOn: paidOn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int newspaperId,
                required DateTime billingMonth,
                required double amountPaid,
                required DateTime paidOn,
              }) => PaymentsCompanion.insert(
                id: id,
                newspaperId: newspaperId,
                billingMonth: billingMonth,
                amountPaid: amountPaid,
                paidOn: paidOn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({newspaperId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (newspaperId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.newspaperId,
                                referencedTable: $$PaymentsTableReferences
                                    ._newspaperIdTable(db),
                                referencedColumn: $$PaymentsTableReferences
                                    ._newspaperIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      Payment,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (Payment, $$PaymentsTableReferences),
      Payment,
      PrefetchHooks Function({bool newspaperId})
    >;
typedef $$DeliveryEntriesTableCreateCompanionBuilder =
    DeliveryEntriesCompanion Function({
      Value<int> id,
      required int newspaperId,
      required DateTime deliveryDate,
      required Status status,
      required double price,
    });
typedef $$DeliveryEntriesTableUpdateCompanionBuilder =
    DeliveryEntriesCompanion Function({
      Value<int> id,
      Value<int> newspaperId,
      Value<DateTime> deliveryDate,
      Value<Status> status,
      Value<double> price,
    });

final class $$DeliveryEntriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $DeliveryEntriesTable, DeliveryEntry> {
  $$DeliveryEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $NewspapersTable _newspaperIdTable(_$AppDatabase db) =>
      db.newspapers.createAlias('deliveryEntries__newspaper_id__newspaper__id');

  $$NewspapersTableProcessedTableManager get newspaperId {
    final $_column = $_itemColumn<int>('newspaper_id')!;

    final manager = $$NewspapersTableTableManager(
      $_db,
      $_db.newspapers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_newspaperIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DeliveryEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $DeliveryEntriesTable> {
  $$DeliveryEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deliveryDate => $composableBuilder(
    column: $table.deliveryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Status, Status, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  $$NewspapersTableFilterComposer get newspaperId {
    final $$NewspapersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.newspaperId,
      referencedTable: $db.newspapers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NewspapersTableFilterComposer(
            $db: $db,
            $table: $db.newspapers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeliveryEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DeliveryEntriesTable> {
  $$DeliveryEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deliveryDate => $composableBuilder(
    column: $table.deliveryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  $$NewspapersTableOrderingComposer get newspaperId {
    final $$NewspapersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.newspaperId,
      referencedTable: $db.newspapers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NewspapersTableOrderingComposer(
            $db: $db,
            $table: $db.newspapers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeliveryEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeliveryEntriesTable> {
  $$DeliveryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get deliveryDate => $composableBuilder(
    column: $table.deliveryDate,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Status, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  $$NewspapersTableAnnotationComposer get newspaperId {
    final $$NewspapersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.newspaperId,
      referencedTable: $db.newspapers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NewspapersTableAnnotationComposer(
            $db: $db,
            $table: $db.newspapers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeliveryEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeliveryEntriesTable,
          DeliveryEntry,
          $$DeliveryEntriesTableFilterComposer,
          $$DeliveryEntriesTableOrderingComposer,
          $$DeliveryEntriesTableAnnotationComposer,
          $$DeliveryEntriesTableCreateCompanionBuilder,
          $$DeliveryEntriesTableUpdateCompanionBuilder,
          (DeliveryEntry, $$DeliveryEntriesTableReferences),
          DeliveryEntry,
          PrefetchHooks Function({bool newspaperId})
        > {
  $$DeliveryEntriesTableTableManager(
    _$AppDatabase db,
    $DeliveryEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeliveryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeliveryEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeliveryEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> newspaperId = const Value.absent(),
                Value<DateTime> deliveryDate = const Value.absent(),
                Value<Status> status = const Value.absent(),
                Value<double> price = const Value.absent(),
              }) => DeliveryEntriesCompanion(
                id: id,
                newspaperId: newspaperId,
                deliveryDate: deliveryDate,
                status: status,
                price: price,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int newspaperId,
                required DateTime deliveryDate,
                required Status status,
                required double price,
              }) => DeliveryEntriesCompanion.insert(
                id: id,
                newspaperId: newspaperId,
                deliveryDate: deliveryDate,
                status: status,
                price: price,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DeliveryEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({newspaperId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (newspaperId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.newspaperId,
                                referencedTable:
                                    $$DeliveryEntriesTableReferences
                                        ._newspaperIdTable(db),
                                referencedColumn:
                                    $$DeliveryEntriesTableReferences
                                        ._newspaperIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DeliveryEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeliveryEntriesTable,
      DeliveryEntry,
      $$DeliveryEntriesTableFilterComposer,
      $$DeliveryEntriesTableOrderingComposer,
      $$DeliveryEntriesTableAnnotationComposer,
      $$DeliveryEntriesTableCreateCompanionBuilder,
      $$DeliveryEntriesTableUpdateCompanionBuilder,
      (DeliveryEntry, $$DeliveryEntriesTableReferences),
      DeliveryEntry,
      PrefetchHooks Function({bool newspaperId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NewspapersTableTableManager get newspapers =>
      $$NewspapersTableTableManager(_db, _db.newspapers);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$DeliveryEntriesTableTableManager get deliveryEntries =>
      $$DeliveryEntriesTableTableManager(_db, _db.deliveryEntries);
}
