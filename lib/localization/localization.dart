import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'localization_en.dart';

abstract class Localization {
  String get scholarAgenda;

  String get close;

  String get edit;

  String get delete;

  String get add;

  String get action;

  String get confirm;

  String get cancel;

  String get areYouSure;

  String get calendar;

  String get manageTimetable;

  String get switchDisplay;

  String get refresh;

  String get createNewTimetable;

  String get yourTimetables;

  String get setAsDefault;

  String get title;

  String get enterATitle;

  String get save;

  String get editTimetable;

  String get formErrorMessage;

  String get pickADate;

  String get pickAStartDate;

  String get pickAEndDate;

  String get valueIsRequired;

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }
}

class ScholarAgendaAppLocalizationsDelegate
    extends LocalizationsDelegate<Localization> {
  const ScholarAgendaAppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) => _load(locale);

  static Future<Localization> _load(Locale locale) async {
    final String name =
        (locale.countryCode == null || locale.countryCode.isEmpty)
            ? locale.languageCode
            : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = localeName;

    if (locale.languageCode == "fr") {
//      return LocalizationFR();
      return LocalizationEN();
    } else {
      return LocalizationEN();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}
