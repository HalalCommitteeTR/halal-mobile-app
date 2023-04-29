// Place fonts/halal-icons.ttf in your fonts/ directory and
// add the following to your pubspec.yaml
// flutter:
//   fonts:
//    - family: halal-icons
//      fonts:
//       - asset: fonts/halal-icons.ttf
import 'package:flutter/widgets.dart';

class HalalIcons {
  HalalIcons._();

  static const String _fontFamily = 'halal-icons';

  static const IconData caterings = IconData(0xe900, fontFamily: _fontFamily);
  static const IconData close = IconData(0xe901, fontFamily: _fontFamily);
  static const IconData directory = IconData(0xe902, fontFamily: _fontFamily);
  static const IconData filter = IconData(0xe903, fontFamily: _fontFamily);
  static const IconData search = IconData(0xe904, fontFamily: _fontFamily);
  static const IconData settings = IconData(0xe905, fontFamily: _fontFamily);
  static const IconData share = IconData(0xe906, fontFamily: _fontFamily);
}
