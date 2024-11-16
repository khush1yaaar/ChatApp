import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  // Define available themes
  static String currentThemeName = 'blue'; // Default theme is blue

  // Map for theme names to corresponding ThemeData and images
  final Map<String, ThemeConfig> themeConfigs = {
    'pink': ThemeConfig(
      themeData: ThemeData(
        primaryColor: Colors.pink,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      homeBg: 'lib/constants/images/pink_theme/home_background.jpg',
      chatBg: 'lib/constants/images/pink_theme/chat_background.jpg',
      contactBg: 'lib/constants/images/pink_theme/contact_background.jpg',
    ),
    'blue': ThemeConfig(
      themeData: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      homeBg: 'lib/constants/images/blue_theme/home_background.jpeg',
      chatBg: 'lib/constants/images/blue_theme/chat_background.jpeg',
      contactBg: 'lib/constants/images/blue_theme/contact_background.jpg',
    ),
    'purple': ThemeConfig(
      themeData: ThemeData(
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      homeBg: 'lib/constants/images/purple_theme/home_background.jpg',
      chatBg: 'lib/constants/images/purple_theme/chat_background.jpg',
      contactBg: 'lib/constants/images/purple_theme/contact_background.jpg',
    ),
    'black': ThemeConfig(
      themeData: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      homeBg: 'lib/constants/images/black_theme/home_background.jpg',
      chatBg: 'lib/constants/images/black_theme/chat_background.jpg',
      contactBg: 'lib/constants/images/black_theme/contact_background.jpg',
    ),
  };

  // Get the current theme
  ThemeData get themeData => themeConfigs[currentThemeName]!.themeData;

  // Get background images for screens
  String get homeBg => themeConfigs[currentThemeName]!.homeBg;
  String get chatBg => themeConfigs[currentThemeName]!.chatBg;
  String get contactBg => themeConfigs[currentThemeName]!.contactBg;

  // Method to change the theme
  void changeTheme(String themeName) {
    if (themeConfigs.containsKey(themeName)) {
      currentThemeName = themeName;
      notifyListeners();
    }
  }
}

// Theme configuration holder
class ThemeConfig {
  final ThemeData themeData;
  final String homeBg;
  final String chatBg;
  final String contactBg;

  ThemeConfig({
    required this.themeData,
    required this.homeBg,
    required this.chatBg,
    required this.contactBg,
  });
}
