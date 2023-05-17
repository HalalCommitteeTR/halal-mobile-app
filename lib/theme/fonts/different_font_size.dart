import 'package:flutter/material.dart';

class different_font_size {
  /*********************************************/
  /*  0.5X
  * Страницы     - 16
  * Заголовки    - 14
  * Подзаголовки - 12
  * Текст        - 10
  *
  */
  static TextTheme get small {
    return TextTheme(
          titleMedium:    TextStyle(fontSize: 16),
          headlineLarge:  TextStyle(fontSize: 14),
          headlineMedium: TextStyle(fontSize: 12),
          bodyMedium:     TextStyle(fontSize: 10)
    );
  }
  /*********************************************/
  /*  1X
  * Страницы     - 18
  * Заголовки    - 16
  * Подзаголовки - 14
  * Текст        - 12
  *
  */
  static TextTheme get medium {
    return TextTheme(
          titleMedium:    TextStyle(fontSize: 28),
          headlineLarge:  TextStyle(fontSize: 16),
          headlineMedium: TextStyle(fontSize: 14),
          bodyMedium:     TextStyle(fontSize: 12)
    );
  }
  /*********************************************/
  /*  2X
  * Страницы     - 20
  * Заголовки    - 18
  * Подзаголовки - 16
  * Текст        - 14
  *
  */
  static TextTheme get large {
    return TextTheme(
          titleMedium:    TextStyle(fontSize: 20),
          headlineLarge:  TextStyle(fontSize: 18),
          headlineMedium: TextStyle(fontSize: 16),
          bodyMedium:     TextStyle(fontSize: 14)
    );
  }

}