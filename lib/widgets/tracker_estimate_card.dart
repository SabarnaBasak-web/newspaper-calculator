import 'package:flutter/material.dart';
import 'package:newspaper_calculator_app/utils/date_utils.dart';

class TrackerEstimateCard extends StatelessWidget {
  const TrackerEstimateCard({required this.amountFuture, super.key});

  final Future<double> amountFuture;

  static const _purple = Color(0xFF6750A4);
  static const _borderColor = Color(0xFF633B48);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '${getMonthName()} Estimate',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          Row(
            children: [
              const Icon(
                Icons.currency_rupee,
                size: 22,
                color: _purple,
                fontWeight: FontWeight.w600,
              ),
              FutureBuilder<double>(
                future: amountFuture,
                builder: (context, snapshot) {
                  final amount = snapshot.data ?? 0.0;

                  return Text(
                    amount.toStringAsFixed(2),
                    style: const TextStyle(
                      color: _purple,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
