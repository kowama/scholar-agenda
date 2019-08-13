import 'dart:convert';

import 'package:scholar_agenda/model/subject.dart';
import 'package:shared_preferences/shared_preferences.dart';

const DOMAIN_NAME = 'com.kowama.scholaragenda';

class Prefs {
  static const SUBJECTS_KEY = '$DOMAIN_NAME.subjects';

  static void saveSubjects(List<Subject> subjects) async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(SUBJECTS_KEY, json.encode(subjects));
  }

  static Future<List<Subject>> getSubjects() async {
    var subjects = List<Subject>();
    var sharedPref = await SharedPreferences.getInstance();

    json
        .decode(sharedPref.getString(SUBJECTS_KEY))
        .forEach((map) => subjects.add(Subject.fromMap(map)));

    return subjects;
  }
}
