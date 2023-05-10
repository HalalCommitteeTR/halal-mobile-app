import 'package:flutter/material.dart';

import 'package:halal_mobile_app/app_locale.dart';

import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';

class HalalAppTheme {
  static Color textColor(Permissiveness permissiveness) {
    switch (permissiveness) {
      case Permissiveness.haram:
        return const Color.fromRGBO(109, 20, 16, 0.6);
      case Permissiveness.halal:
        return const Color.fromRGBO(17, 109, 51, 0.6);
      case Permissiveness.doubtful:
        return const Color.fromRGBO(17, 46, 82, 0.6);
    }
  }

  static Color backgroundColor(Permissiveness permissiveness) {
    switch (permissiveness) {
      case Permissiveness.haram:
        return const Color.fromRGBO(181, 34, 27, 0.1);
      case Permissiveness.halal:
        return const Color.fromRGBO(17, 109, 51, 0.1);
      case Permissiveness.doubtful:
        return const Color.fromRGBO(28, 76, 137, 0.1);
    }
  }

  static String permissivenessLabel(
    BuildContext context,
    Permissiveness permissiveness,
  ) {
    switch (permissiveness) {
      case Permissiveness.haram:
        return AppLocale.of(context).haram;
      case Permissiveness.halal:
        return AppLocale.of(context).halal;
      case Permissiveness.doubtful:
        return AppLocale.of(context).doubtful;
    }
  }

  static const accentColor = Color(0xff1cb555);
  static const unselectedColor = Color(0xFF7E8188);
  static const halalBackgroundColor = Color.fromRGBO(17, 109, 51, 0.1);
  static const haramBackgroundColor = Color.fromRGBO(181, 34, 27, 0.1);
  static const doubtfulBackgroundColor = Color.fromRGBO(28, 76, 137, 0.1);
  static const halalTextColor = Color.fromRGBO(17, 109, 51, 0.6);
  static const haramTextColor = Color.fromRGBO(109, 20, 16, 0.6);
  static const doubtfulTextColor = Color.fromRGBO(17, 46, 82, 0.6);

  static ThemeData get light {
    return ThemeData(
      fontFamily: 'OpenSans',
      primaryColor: accentColor,
      unselectedWidgetColor: unselectedColor,
      iconTheme: IconThemeData(
        color: unselectedColor,
      ),
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
    return ThemeData.dark();
  }
}
