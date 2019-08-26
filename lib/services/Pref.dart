//import 'dart:convert';
//
//import 'package:scholar_agenda/model/subject.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//const DOMAIN_NAME = 'com.kowama.scholaragenda';
//
//class Prefs {
//  static const SUBJECTS_KEY = '$DOMAIN_NAME.subjects';
//
//  static void saveSubjects(List<Subjects> subjects) async {
//    var sharedPref = await SharedPreferences.getInstance();
//    sharedPref.setString(SUBJECTS_KEY, json.encode(subjects));
//  }
//
//  static Future<List<Subjects>> getSubjects() async {
//    var subjects = List<Subjects>();
//    var sharedPref = await SharedPreferences.getInstance();
//
//    json
//        .decode(sharedPref.getString(SUBJECTS_KEY))
//        .forEach((map) => subjects.add(Subjects.fromMap(map)));
//
//    return subjects;
//  }
//}
