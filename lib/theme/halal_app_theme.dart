import 'package:flutter/material.dart';

class HalalAppTheme {
  static const accentColor = Color(0xff1cb555);
  static const unselectedColor = Color(0xFF7E8188);
  static ThemeData get light {
    return ThemeData(
      fontFamily: 'OpenSans',
      primaryColor: accentColor,
      unselectedWidgetColor: unselectedColor,
      iconTheme: IconThemeData(color: unselectedColor,),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        margin: const EdgeInsets.all(10),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: accentColor,
      ),
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