import 'dart:convert';

import 'package:scholar_agenda/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

const DOMAIN_NAME = 'com.kowama.scholaragenda';

class Preferences {
  static const DEFAULT_TIMETABLE = '$DOMAIN_NAME.defaultTimetable';
  static final Preferences _preferences = Preferences._internal();

  static SharedPreferences _sharedPreferences;

  static Future initialize() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  factory Preferences() {
    return _preferences;
  }

  Preferences._internal();

  Future<bool> updateDefaultTimetable(Timetable timetable) async {
    assert(_sharedPreferences != null, 'must be iniitialize before call');

    return await _sharedPreferences.setString(
        DEFAULT_TIMETABLE, json.encode(timetable));
  }

  Future<Timetable> getDefaultTimetable() async {
    assert(_sharedPreferences != null, 'must be iniitialize before call');

    final jsonString = _sharedPreferences.getString(DEFAULT_TIMETABLE);
    return jsonString == null
        ? null
        : Timetable.fromDataClass(TimetableDataClass.fromJson(
            json.decode(jsonString),
          ));
  }
}
