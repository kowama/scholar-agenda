import 'localization.dart';

class LocalizationEN implements Localization {
  @override
  String get add => 'Add';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get close => 'Close';

  @override
  String get action => 'Action';

  @override
  String get confirm => 'Confirm';

  @override
  String get areYouSure => 'Are you sure ?';

  @override
  String get cancel => 'Cancel';

  @override
  String get calendar => 'Calendar';

  @override
  String get scholarAgenda => 'Scholar agenda';

  @override
  String get manageTimetable => 'Manage timetable';

  @override
  String get refresh => 'Refresh';

  @override
  String get switchDisplay => 'Switch display';

  @override
  String get createNewTimetable => 'Create new timetable';

  @override
  String get yourTimetables => 'Your timetables';

  @override
  String get setAsDefault => 'Set as default';

  @override
  String get title => 'Title';

  @override
  String get enterATitle => 'Enter a title';

  @override
  String get save => 'Save';

  @override
  String get editTimetable => 'Edit timetable';

  @override
  String get formErrorMessage =>
      'Please fix the errors in red before submitting.';

  @override
  String get pickADate => 'Pick a date';

  @override
  String get pickAStartDate => 'Pick a start date';

  @override
  String get pickAEndDate => 'Pick a end date';

  @override
  String get valueIsRequired => 'Please enter a value';

  @override
  List<String> get days => [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
      ];

  @override
  String dayOfWeek(int day) {
    assert(day >= 1 && day <= 7);
    return days[day - 1];
  }

  @override
  String get subject => 'Subject';

  @override
  String get subjectCreate => 'Subject create';

  @override
  String get subjectEdit => 'Subject edit';

  @override
  String get timetable => 'Timetable';

  @override
  String get settings => 'Settings';

  @override
  String get agenda => 'Agenda';

  @override
  String get helpAndFeedBack => 'Help and feedback';

  @override
  String get overview => 'Overview';

  @override
  String get errorUnableToLoadData => 'Error unable to load data';

  @override
  String get errorUnknownState => 'Error unknown state';
}
