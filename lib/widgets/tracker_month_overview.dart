import 'package:flutter/material.dart';
import 'package:newspaper_calculator_app/utils/date_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class TrackerMonthOverview extends StatelessWidget {
  const TrackerMonthOverview({required this.loggedDatesStream, super.key});

  final Stream<Set<DateTime>> loggedDatesStream;

  static const _purple = Color(0xFF6750A4);
  static const _green = Color(0xFF2E7D32);
  static const _borderColor = Color(0xFF633B48);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: getCurrentMonthCompletionRatio(),
          minHeight: 8,
          borderRadius: BorderRadius.circular(8),
          valueColor: const AlwaysStoppedAnimation<Color>(_purple),
          backgroundColor: const Color(0xFFE5E1E7),
        ),
        const SizedBox(height: 10),
        Text(
          '${getMonthName()} ${DateTime.now().year}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        Text(
          '${getCurrentDay()} of ${getTotalDaysInCurrentMonth()} days recorded',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        StreamBuilder<Set<DateTime>>(
          stream: loggedDatesStream,
          builder: (context, snapshot) {
            final loggedDates = snapshot.data ?? const <DateTime>{};

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: _borderColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime.utc(2026, 01, 01),
                lastDay: DateTime.utc(2099, 12, 31),
                calendarFormat: CalendarFormat.month,
                eventLoader: (day) {
                  final normalizedDay = DateTime(day.year, day.month, day.day);
                  return loggedDates.contains(normalizedDay)
                      ? const ['logged']
                      : const [];
                },
                calendarStyle: const CalendarStyle(
                  markerDecoration: BoxDecoration(
                    color: _green,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
