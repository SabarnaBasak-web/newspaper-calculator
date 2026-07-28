import 'package:flutter/material.dart';
import 'package:newspaper_calculator_app/database/app_database.dart';

class PublicationCard extends StatelessWidget {
  const PublicationCard({
    required this.newspaper,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final Newspaper newspaper;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  static const _purple = Color(0xFF6750A4);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: const Color(0xFFFFFBFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFFB8A1AA)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFE9DDFF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.newspaper_rounded, color: _purple, size: 23),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          newspaper.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: _purple,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _StatusBadge(isActive: newspaper.isActive),
                      const SizedBox(width: 6),
                      _ActionBadge(
                        icon: Icons.edit_outlined,
                        color: _purple,
                        tooltip: 'Edit publication',
                        onTap: onEdit,
                      ),
                      const SizedBox(width: 6),
                      _ActionBadge(
                        icon: Icons.delete_outline,
                        color: const Color(0xFFBA1A1A),
                        tooltip: 'Delete publication',
                        onTap: onDelete,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _PriceBadge(
                        label: 'Weekday',
                        price: newspaper.weekdayPrice,
                      ),
                      _PriceBadge(
                        label: 'Weekend',
                        price: newspaper.weekendPrice,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionBadge extends StatelessWidget {
  const _ActionBadge({
    required this.icon,
    required this.color,
    required this.tooltip,
    this.onTap,
  });

  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Semantics(
        label: tooltip,
        button: onTap != null,
        child: Material(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(7),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(7),
            child: SizedBox(
              width: 28,
              height: 28,
              child: Icon(icon, color: color, size: 17),
            ),
          ),
        ),
      ),
    );
  }
}

class _PriceBadge extends StatelessWidget {
  const _PriceBadge({required this.label, required this.price});

  final String label;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF1EAFE),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '$label  ₹${price.toStringAsFixed(2)}',
        style: const TextStyle(
          color: Color(0xFF6750A4),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? const Color(0xFF2E7D32) : const Color(0xFF757575);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
