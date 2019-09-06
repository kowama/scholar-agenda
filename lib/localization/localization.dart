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

  String get titleHint;

  String get save;

  String get editTimetable;

  String get formErrorMessage;

  String get dateHint;

  String get pickAStartDate;

  String get pickAEndDate;

  String get valueIsRequired;

  String get subject;

  List<String> get days;

  String get subjectCreate;

  String get subjectEdit;

  String get timetable;

  String get settings;

  String get helpAndFeedBack;

  String get agenda;

  String get overview;

  String get errorUnableToLoadData;

  String get errorUnknownState;

  String get defaultTimetableNotSet;

  String get pickASubject;

  String get pickADay;

  String get createPeriod;

  String get editPeriod;

  String get youHave;

  String get classes;

  String get day;

  String get period;

  String get noHomework;

  String get noExams;

  String get noReminders;

  String get home;

  String get noSubject;

  String get pickAColor;

  String get subjectDescriptionHint;

  String get formHasErrors;

  String get subjectDescriptionHelper;

  String get yes;

  String get no;

  String get leaveForm;

  String get pleaseFixErrors;

  String get teacher;

  String get enterTeacherName;

  String get ok;

  String get custom;

  String get noTimetables;

  String get roomHint;

  String get room;

  String get end;

  String get start;

  String get undefined;

  String get homework;

  String get exam;

  String get reminder;

  String get description;

  String get descriptionHint;

  String get date;

  String get create;

  String get startCantBeBeforeAfter;

  String get share;

  String dayOfWeek(int day);

  /// typeValue 0(Homework) 1(Exam) 2(Reminder)
  String eventType(int typeValue);

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

class DaysOfWeek {
  final int value;
  final String name;

  const DaysOfWeek(this.value, this.name);
}
