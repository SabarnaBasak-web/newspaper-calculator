int getTotalDaysInCurrentMonth() {
  final currentDateTime = DateTime.now();
  return DateTime(currentDateTime.year, currentDateTime.month + 1, 0).day;
}

int getCurrentDay() {
  final currentDateTime = DateTime.now();
  return currentDateTime.day;
}

double getCurrentMonthCompletionRatio() {
  final currentDay = getCurrentDay();
  final totalDaysInMonth = getTotalDaysInCurrentMonth();
  final progress = currentDay / totalDaysInMonth;

  return progress;
}

String getMonthName([DateTime? date]) {
  final month = (date ?? DateTime.now()).month;

  List<String> monthName = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  return monthName[month];
}

bool isWeekend(DateTime date) {
  return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
}

bool isWeekday(DateTime date) {
  return !isWeekend(date);
}
