import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLocale {
  // static const _en = Locale('en');
  static const _ru = Locale('ru');

  static const supportedLocales = [_ru];

  static LocalizationsDelegate<AppLocalizations> get delegate =>
      AppLocalizations.delegate;

  static List<LocalizationsDelegate<dynamic>> get localizationDelegates =>
      AppLocalizations.localizationsDelegates;

  static String getCurrentLocale(BuildContext context) =>
      Localizations.localeOf(context).toString();

  static String getFormattedDate(BuildContext context, DateTime date) =>
      DateFormat.yMMMMd(
        AppLocale.getCurrentLocale(context),
      ).format(date);

  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context)!;

  // static bool isEn(Locale locale) => locale == _en;

  const AppLocale._();
}
