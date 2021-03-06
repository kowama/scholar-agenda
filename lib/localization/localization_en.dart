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
  String get titleHint => 'Enter a title';

  @override
  String get save => 'Save';

  @override
  String get editTimetable => 'Edit timetable';

  @override
  String get formErrorMessage =>
      'Please fix the errors in red before submitting.';

  @override
  String get dateHint => 'Pick a date';

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

  @override
  String get defaultTimetableNotSet => 'Default timtable not set';

  @override
  String get pickASubject => 'Pick a subject';

  @override
  String get pickADay => 'Pick a day';

  @override
  String get createPeriod => 'Create Period';

  @override
  String get editPeriod => 'Edit Period';

  @override
  String get youHave => 'You have';

  @override
  String get classes => 'Classes';

  @override
  String get day => 'Day';

  @override
  String get period => 'Period';

  @override
  String get noHomework => 'No homework';

  @override
  String get noExams => 'No exams';

  @override
  String get noReminders => 'No reminders';

  @override
  String get home => 'Home';

  @override
  String get noSubject => 'No subjects';

  @override
  String get pickAColor => 'Pick a color';

  @override
  String get subjectDescriptionHint =>
      'Somme description or other details about the subject';

  @override
  String get subjectDescriptionHelper =>
      'a short description text about the subject';

  @override
  String get formHasErrors => 'This form has errors';

  String get leaveForm => 'Really leave this form?';

  @override
  String get no => 'NO';

  @override
  String get yes => 'YES';

  @override
  String get pleaseFixErrors =>
      'Please fix the errors in red before submitting.';

  @override
  String get enterTeacherName => 'Enter teacher name';

  @override
  String get teacher => 'Teacher';

  @override
  String get ok => 'OK';

  @override
  String get custom => 'Custom';

  @override
  String get noTimetables => 'No timetable available';

  @override
  String get roomHint => 'Enter a room name';

  @override
  String get room => 'Room';

  @override
  String get end => 'End';

  @override
  String get start => 'Sart';

  @override
  String get undefined => 'Undefined';

  @override
  String get exam => 'Exam';

  @override
  String get homework => 'Homework';

  @override
  String get reminder => 'Reminder';

  @override
  String get description => 'Description';

  @override
  String get descriptionHint => 'Add a description text';

  @override
  String eventType(int typeValue) {
    assert(typeValue >= 0 && typeValue <= 2);
    final types = ['Homework', 'Exam', 'Reminder'];
    return types[typeValue];
  }

  @override
  String get date => 'Date';

  @override
  String get create => 'Create';

  @override
  String get startCantBeBeforeAfter => 'Star can\'t be before after';

  @override
  String get share => 'Share';

  @override
  String repeatModeToString(int repeatModeValue) {
    assert(repeatModeValue >= 0 && repeatModeValue <= 4);
    final repeatMode = [
      'No repeat',
      'Day',
      'Week',
      'Two Week',
      'Two Month',
    ];
    return repeatMode[repeatModeValue];
  }

  @override
  String get none => 'None';

  @override
  String get dueDate => 'Due date';

  @override
  String get allTheDay => 'All the day';

  @override
  String get repeatMode => 'Repeat mode';

  @override
  String get daysAgo => 'Days ago';

  @override
  String get daysBefore => 'Days before';
}
