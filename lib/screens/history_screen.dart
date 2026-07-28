import 'package:flutter/material.dart';
import 'package:newspaper_calculator_app/database/app_database.dart';
import 'package:newspaper_calculator_app/models/monthly_payment.dart';
import 'package:newspaper_calculator_app/utils/date_utils.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({required this.database, super.key});

  final AppDatabase database;

  static const _purple = Color(0xFF6750A4);
  static const _ink = Color(0xFF211A22);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9DDFF),
        title: const Text(
          'Payment History',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight(600),
            color: _purple,
          ),
        ),
      ),
      body: StreamBuilder<List<MonthlyPayment>>(
        stream: database.watchMonthlyPaymentHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Unable to load payment history'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final history = snapshot.data!;
          final now = DateTime.now();
          final currentYear = now.year;
          final currentMonth = DateTime(now.year, now.month);
          final completedMonths = history
              .where((entry) => entry.billingMonth.isBefore(currentMonth))
              .toList();
          final yearTotal = history
              .where(
                (entry) =>
                    entry.billingMonth.year == currentYear && entry.isSettled,
              )
              .fold<double>(0, (total, entry) => total + entry.amountPaid);

          return SafeArea(
            top: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              children: [
                _TotalCard(amount: yearTotal),
                const SizedBox(height: 26),
                const Text(
                  'Recent Payments',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                if (completedMonths.isEmpty)
                  const _EmptyHistory()
                else
                  for (final payment in completedMonths) ...[
                    _PaymentTile(
                      payment: payment,
                      onMarkAsPaid: () => _markAsPaid(context, payment),
                    ),
                    const SizedBox(height: 12),
                  ],
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _markAsPaid(BuildContext context, MonthlyPayment payment) async {
    try {
      await database.settleMonth(payment.billingMonth);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${getMonthName(payment.billingMonth)} marked as paid.',
          ),
        ),
      );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not update the payment.')),
      );
    }
  }
}

class _TotalCard extends StatelessWidget {
  const _TotalCard({required this.amount});

  final double amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      decoration: BoxDecoration(
        color: HistoryScreen._purple,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Total Paid Year-to-Date',
            style: TextStyle(
              color: Color(0xFFE8DFF2),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  const _PaymentTile({required this.payment, required this.onMarkAsPaid});

  final MonthlyPayment payment;
  final VoidCallback onMarkAsPaid;

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(
      payment.billingMonth.year,
      payment.billingMonth.month + 1,
      0,
    ).day;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE7DDE9)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xFFF0EAF1),
            child: Icon(
              Icons.event_available_outlined,
              color: HistoryScreen._purple,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${getMonthName(payment.billingMonth)} '
                  '${payment.billingMonth.year}',
                  style: const TextStyle(
                    color: HistoryScreen._ink,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${payment.receivedDays} of $daysInMonth days received',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF6F6570),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${payment.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: HistoryScreen._ink,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              _StatusChip(isSettled: payment.isSettled),
              if (!payment.isSettled) ...[
                const SizedBox(height: 5),
                SizedBox(
                  height: 25,
                  child: FilledButton(
                    onPressed: onMarkAsPaid,
                    style: FilledButton.styleFrom(
                      backgroundColor: HistoryScreen._purple,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      textStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                    child: const Text('Mark as Paid'),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.isSettled});

  final bool isSettled;

  @override
  Widget build(BuildContext context) {
    final background = isSettled
        ? const Color(0xFFE9E2E9)
        : const Color(0xFFFFE0E0);
    final foreground = isSettled
        ? const Color(0xFF514851)
        : const Color(0xFF9B1C1C);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        isSettled ? 'Settled' : 'Pending',
        style: TextStyle(
          color: foreground,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 64),
      child: Column(
        children: [
          Icon(Icons.receipt_long_outlined, size: 44, color: Color(0xFF8A7F8B)),
          SizedBox(height: 12),
          Text(
            'No payments recorded yet',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
