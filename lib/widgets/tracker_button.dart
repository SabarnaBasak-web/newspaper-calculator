import 'package:flutter/material.dart';

class TrackerButton extends StatelessWidget {
  const TrackerButton({required this.onPressed, super.key});

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 157,
      child: FilledButton.icon(
        onPressed: onPressed,
        label: const Text('Received'),
        style: FilledButton.styleFrom(
          backgroundColor: Color(0xFF6750A4),
          foregroundColor: Colors.white,
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
