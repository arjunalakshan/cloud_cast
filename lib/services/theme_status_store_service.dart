import 'package:shared_preferences/shared_preferences.dart';

class ThemeStatusStoreService {
  //* Store theme status in shared preferences
  Future<void> storeThemeStatus(bool isDarkMode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("dark_mode_enabled", isDarkMode);
  }

  //* Get the stored theme status
  Future<bool> getThemeStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("dark_mode_enabled") ?? false;
  }
}
