import 'package:flutter/material.dart';
import 'package:newspaper_calculator_app/database/app_database.dart';
import 'package:newspaper_calculator_app/utils/date_utils.dart';
import 'package:newspaper_calculator_app/widgets/today_log_section.dart';
import 'package:newspaper_calculator_app/widgets/tracker_estimate_card.dart';
import 'package:newspaper_calculator_app/widgets/tracker_month_overview.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({required this.database, super.key});

  final AppDatabase database;

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  static const _purple = Color(0xFF6750A4);

  Future<void> _logDailyDelivery(Newspaper newspaper, Status status) async {
    final today = DateTime.now();
    final price = isWeekend(today)
        ? newspaper.weekendPrice
        : newspaper.weekdayPrice;

    try {
      await widget.database.addDailyDeliveryEntry(
        newspaperId: newspaper.id,
        status: status,
        price: price,
      );

      if (!mounted) return;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${newspaper.name} marked ${status.name}.')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save today\'s log.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9DDFF),

        title: const Text(
          'Delivery Log',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight(600),
            color: _purple,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              TrackerMonthOverview(
                loggedDatesStream: widget.database
                    .watchLoggedDeliveryDatesForCurrentMonth(),
              ),
              const SizedBox(height: 20),
              TrackerEstimateCard(
                amountFuture: widget.database.getAmountGeneratedUntilToday(),
              ),
              const SizedBox(height: 20),
              TodayLogSection(
                newspapersStream: widget.database.watchActiveNewspapers(),
                loggedNewspaperIdsFuture: widget.database
                    .getLoggedNewspaperIdsForToday(),
                onLog: _logDailyDelivery,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
