import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class ClipFlowApp extends StatefulWidget {
  const ClipFlowApp({super.key});

  @override
  State<ClipFlowApp> createState() => _ClipFlowAppState();
}

class _ClipFlowAppState extends State<ClipFlowApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF6750A4);

    return MaterialApp(
      title: 'ClipFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Roboto',
      ),
      themeMode: _themeMode,
      home: HomeScreen(onToggleTheme: toggleTheme, themeMode: _themeMode),
    );
  }
}
