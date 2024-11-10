import 'package:flutter/material.dart'; // Importing Flutter material package for UI components.

// Creating an instance of CustomTheme to manage the theme state.
CustomTheme currentTheme = CustomTheme();

// CustomTheme class to handle theme toggling and state management.
class CustomTheme with ChangeNotifier {
  // A static boolean to track the current theme (true for dark, false for light).
  static bool isDarkTheme = true;

  // Getter to return the current theme mode based on isDarkTheme.
  ThemeMode get currentTheme => isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  // Method to toggle the theme and notify listeners.
  void toggleTheme() {
    isDarkTheme = !isDarkTheme; // Toggle the boolean value.
    notifyListeners(); // Notify listeners about the change.
  }

  // Getter to return the light theme data.
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.blue.shade300, // Primary color for the light theme.
      scaffoldBackgroundColor: Colors.grey.shade100, // Background color for the scaffold.

      // AppBar theme settings for the light theme.
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue.shade300, // Background color for the AppBar.
        titleTextStyle: TextStyle(color: Colors.white), // Text style for the AppBar title.
        iconTheme: IconThemeData(color: Colors.white), // Icon theme for the AppBar.
      ),

      // Text theme settings for the light theme.
      textTheme: TextTheme(
        displayLarge: TextStyle(color: Colors.grey.shade900), // Large display text color.
        displayMedium: TextStyle(color: Colors.grey.shade900), // Medium display text color.
        displaySmall: TextStyle(color: Colors.grey.shade900), // Small display text color.
        headlineLarge: TextStyle(color: Colors.blue.shade900), // Large headline text color.
        headlineMedium: TextStyle(color: Colors.blue.shade900), // Medium headline text color.
        headlineSmall: TextStyle(color: Colors.blue.shade900), // Small headline text color.
        bodyLarge: TextStyle(color: Colors.grey.shade900), // Large body text color.
        bodyMedium: TextStyle(color: Colors.grey.shade900), // Medium body text color.
        bodySmall: TextStyle(color: Colors.grey.shade900), // Small body text color.
      ),
    );
  }

  // Getter to return the dark theme data.
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.blue.shade800, // Primary color for the dark theme.
      scaffoldBackgroundColor: Colors.grey.shade900, // Background color for the scaffold.

      // AppBar theme settings for the dark theme.
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue.shade800, // Background color for the AppBar.
        titleTextStyle: TextStyle(color: Colors.white), // Text style for the AppBar title.
        iconTheme: IconThemeData(color: Colors.white), // Icon theme for the AppBar.
      ),
      
      // Text theme settings for the dark theme.
      textTheme: TextTheme(
        displayLarge: TextStyle(color: Colors.grey.shade300), // Large display text color.
        displayMedium: TextStyle(color: Colors.grey.shade300), // Medium display text color.
        displaySmall: TextStyle(color: Colors.grey.shade300), // Small display text color.
        headlineLarge: TextStyle(color: Colors.blue.shade300), // Large headline text color.
        headlineMedium: TextStyle(color: Colors.blue.shade300), // Medium headline text color.
        headlineSmall: TextStyle(color: Colors.blue.shade300), // Small headline text color.
        bodyLarge: TextStyle(color: Colors.grey.shade300), // Large body text color.
        bodyMedium: TextStyle(color: Colors.grey.shade300), // Medium body text color.
        bodySmall: TextStyle(color: Colors.grey.shade300), // Small body text color.
      ),
    );
  }
}
