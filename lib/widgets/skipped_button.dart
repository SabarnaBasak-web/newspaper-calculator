import 'package:flutter/material.dart';

class SkippedButton extends StatelessWidget {
  const SkippedButton({required this.onPressed, super.key});

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 157,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        label: const Text('Skipped'),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF6750A4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
