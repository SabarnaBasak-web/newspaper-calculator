import 'package:flutter/material.dart';
import 'package:newspaper_calculator_app/database/app_database.dart';
import 'package:newspaper_calculator_app/utils/date_utils.dart';

class TodayLogSection extends StatelessWidget {
  const TodayLogSection({
    required this.newspapersStream,
    required this.loggedNewspaperIdsFuture,
    required this.onLog,
    super.key,
  });

  final Stream<List<Newspaper>> newspapersStream;
  final Future<Set<int>> loggedNewspaperIdsFuture;
  final Future<void> Function(Newspaper newspaper, Status status) onLog;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Newspaper>>(
      stream: newspapersStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _TodayLogCard(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final newspapers = snapshot.data ?? const <Newspaper>[];
        if (newspapers.isEmpty) return const SizedBox.shrink();

        return FutureBuilder<Set<int>>(
          future: loggedNewspaperIdsFuture,
          builder: (context, loggedSnapshot) {
            final loggedNewspaperIds = loggedSnapshot.data ?? const <int>{};
            final pendingNewspapers = newspapers
                .where(
                  (newspaper) => !loggedNewspaperIds.contains(newspaper.id),
                )
                .toList();

            if (pendingNewspapers.isEmpty &&
                loggedSnapshot.connectionState != ConnectionState.waiting) {
              return const SizedBox.shrink();
            }

            return _TodayLogCard(
              child: loggedSnapshot.connectionState == ConnectionState.waiting
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Column(
                      children: [
                        for (final newspaper in pendingNewspapers) ...[
                          _TodayLogRow(
                            newspaper: newspaper,
                            onReceived: () => onLog(newspaper, Status.received),
                            onSkipped: () => onLog(newspaper, Status.skipped),
                          ),
                          if (newspaper != pendingNewspapers.last)
                            const SizedBox(height: 8),
                        ],
                      ],
                    ),
            );
          },
        );
      },
    );
  }
}

class _TodayLogCard extends StatelessWidget {
  const _TodayLogCard({required this.child});

  final Widget child;

  static const _borderColor = Color(0xFF633B48);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor),
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFE9DDFF),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Log for today (${getMonthName()} ${getCurrentDay()})',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _TodayLogRow extends StatelessWidget {
  const _TodayLogRow({
    required this.newspaper,
    required this.onReceived,
    required this.onSkipped,
  });

  final Newspaper newspaper;
  final VoidCallback onReceived;
  final VoidCallback onSkipped;

  static const _purple = Color(0xFF6750A4);
  static const _dangerColor = Color(0xFFBA1A1A);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 48),
      padding: const EdgeInsets.fromLTRB(12, 6, 6, 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBFF),
        border: Border.all(color: const Color(0xFFD5CDD8)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              newspaper.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 8),
          _LogActionButton(
            tooltip: 'Mark received',
            icon: Icons.check,
            color: _purple,
            isFilled: true,
            onTap: onReceived,
          ),
          const SizedBox(width: 6),
          _LogActionButton(
            tooltip: 'Mark skipped',
            icon: Icons.close,
            color: _dangerColor,
            onTap: onSkipped,
          ),
        ],
      ),
    );
  }
}

class _LogActionButton extends StatelessWidget {
  const _LogActionButton({
    required this.tooltip,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isFilled = false,
  });

  final String tooltip;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    final foreground = isFilled ? Colors.white : color;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: isFilled ? color : Colors.white,
        shape: CircleBorder(
          side: BorderSide(color: isFilled ? color : const Color(0xFF8A808D)),
        ),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 34,
            height: 34,
            child: Icon(icon, color: foreground, size: 20),
          ),
        ),
      ),
    );
  }
}
