import 'package:flutter/material.dart';

class HalalAppTheme {
  static const accentColor = Color(0xff1cb555);
  static ThemeData get light {
    return ThemeData(
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: accentColor,
        selectedItemColor: accentColor,

      ),
    );
  }

  static ThemeData get dark {
    return ThemeData.dark(

    );
  }
}