import 'package:flutter/material.dart';
import 'package:newspaper_calculator_app/database/app_database.dart';
import 'package:newspaper_calculator_app/screens/history_screen.dart';
import 'package:newspaper_calculator_app/screens/paper_screen.dart';
import 'package:newspaper_calculator_app/screens/settings_screen.dart';
import 'package:newspaper_calculator_app/screens/tracker_screen.dart';
import 'package:newspaper_calculator_app/widgets/stock_bottom_navigator.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({
    required this.database,
    required this.isDarkMode,
    required this.onDarkModeChanged,
    super.key,
  });

  final AppDatabase database;
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;

  void onTapHandler(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          TrackerScreen(database: widget.database),
          PaperScreen(database: widget.database),
          HistoryScreen(database: widget.database),
          SettingsScreen(
            isDarkMode: widget.isDarkMode,
            onDarkModeChanged: widget.onDarkModeChanged,
          ),
        ],
      ),
      bottomNavigationBar: StockBottomNavigator(
        currentIndex: _selectedIndex,
        onTap: onTapHandler,
      ),
    );
  }
}
