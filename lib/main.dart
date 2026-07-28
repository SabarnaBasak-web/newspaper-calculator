import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newspaper_calculator_app/database/app_database.dart';
import 'package:newspaper_calculator_app/screens/root_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NewspaperCalculatorApp());
}

class NewspaperCalculatorApp extends StatefulWidget {
  const NewspaperCalculatorApp({super.key});

  @override
  State<NewspaperCalculatorApp> createState() => _NewspaperCalculatorAppState();
}

class _NewspaperCalculatorAppState extends State<NewspaperCalculatorApp> {
  late final AppDatabase _database;
  ThemeMode _themeMode = ThemeMode.light;

  void _setDarkMode(bool enabled) {
    setState(() {
      _themeMode = enabled ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  void initState() {
    super.initState();
    _database = AppDatabase();
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newspaper Calculator',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.nunitoTextTheme(ThemeData.dark().textTheme),
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: .fromSeed(seedColor: const Color(0xFF6750A4)),
        textTheme: GoogleFonts.nunitoTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF6EEFF),
      ),
      home: RootScreen(
        database: _database,
        isDarkMode: _themeMode == ThemeMode.dark,
        onDarkModeChanged: _setDarkMode,
      ),
    );
  }
}
