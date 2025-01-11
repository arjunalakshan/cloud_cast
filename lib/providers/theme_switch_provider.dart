import 'package:cloud_cast/services/theme_status_store_service.dart';
import 'package:cloud_cast/utils/app_themes.dart';
import 'package:flutter/material.dart';

class ThemeSwitchProvider extends ChangeNotifier {
  ThemeSwitchProvider() {
    _getThemeStatus();
  }

  ThemeData _themeData = AppThemes().lightMode;

  final ThemeStatusStoreService _themeStatusStoreService =
      ThemeStatusStoreService();

  //* Getter for get theme
  ThemeData get getThemeMode => _themeData;

  //* Setter for set and update theme
  set setThemeMode(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  //* get stored theme status
  Future<void> _getThemeStatus() async {
    bool isDarkMode = await _themeStatusStoreService.getThemeStatus();
    setThemeMode = isDarkMode ? AppThemes().darkMode : AppThemes().lightMode;
  }

  //* Toggle and store new theme status
  Future<void> toggleAndStoreThemeStatus(bool isDarkMode) async {
    setThemeMode = isDarkMode ? AppThemes().darkMode : AppThemes().lightMode;
    await _themeStatusStoreService.storeThemeStatus(isDarkMode);
    notifyListeners();
  }
}
