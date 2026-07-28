import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    required this.isDarkMode,
    required this.onDarkModeChanged,
    super.key,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  static const _purple = Color(0xFF6750A4);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9DDFF),
        title: const Row(
          children: [
            Icon(Icons.settings_outlined, size: 22, color: _purple),
            SizedBox(width: 8),
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: _purple,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          children: [
            Material(
              color: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: colorScheme.outline),
              ),
              clipBehavior: Clip.antiAlias,
              child: SwitchListTile(
                value: isDarkMode,
                onChanged: onDarkModeChanged,
                activeThumbColor: Colors.white,
                activeTrackColor: _purple,
                secondary: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFFE9DDFF),
                  child: Icon(
                    Icons.dark_mode_outlined,
                    color: _purple,
                    size: 21,
                  ),
                ),
                title: Text(
                  'App Theme',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                subtitle: Text(
                  isDarkMode ? 'Dark mode' : 'Light mode',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
