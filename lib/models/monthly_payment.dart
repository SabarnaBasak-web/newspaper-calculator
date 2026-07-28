class MonthlyPayment {
  const MonthlyPayment({
    required this.billingMonth,
    required this.amount,
    required this.amountPaid,
    required this.paidOn,
    required this.paymentCount,
    required this.receivedDays,
  });

  final DateTime billingMonth;
  final double amount;
  final double amountPaid;
  final DateTime? paidOn;
  final int paymentCount;
  final int receivedDays;

  bool get isSettled => amountPaid >= amount && amount > 0;
}
