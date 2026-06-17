import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;

  // ── Load saved theme on startup ──
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    // No notifyListeners() here — called before runApp
  }

  Future<void> toggleTheme(bool isDark) async {
    if (_themeMode == (isDark ? ThemeMode.dark : ThemeMode.light)) return;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    // ── Persist ──
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
    notifyListeners();
  }
}