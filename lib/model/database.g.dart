// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Period extends DataClass implements Insertable<Period> {
  final int id;
  final int dayOfWeek;
  final DateTime start;
  final DateTime end;
  final String location;
  Period(
      {@required this.id,
      @required this.dayOfWeek,
      this.start,
      this.end,
      this.location});
  factory Period.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    return Period(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      dayOfWeek: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}day_of_week']),
      start:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}start']),
      end: dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}end']),
      location: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}location']),
    );
  }
  factory Period.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Period(
      id: serializer.fromJson<int>(json['id']),
      dayOfWeek: serializer.fromJson<int>(json['dayOfWeek']),
      start: serializer.fromJson<DateTime>(json['start']),
      end: serializer.fromJson<DateTime>(json['end']),
      location: serializer.fromJson<String>(json['location']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'dayOfWeek': serializer.toJson<int>(dayOfWeek),
      'start': serializer.toJson<DateTime>(start),
      'end': serializer.toJson<DateTime>(end),
      'location': serializer.toJson<String>(location),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Period>>(bool nullToAbsent) {
    return PeriodsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      dayOfWeek: dayOfWeek == null && nullToAbsent
          ? const Value.absent()
          : Value(dayOfWeek),
      start:
          start == null && nullToAbsent ? const Value.absent() : Value(start),
      end: end == null && nullToAbsent ? const Value.absent() : Value(end),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
    ) as T;
  }

  Period copyWith(
          {int id,
          int dayOfWeek,
          DateTime start,
          DateTime end,
          String location}) =>
      Period(
        id: id ?? this.id,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        start: start ?? this.start,
        end: end ?? this.end,
        location: location ?? this.location,
      );
  @override
  String toString() {
    return (StringBuffer('Period(')
          ..write('id: $id, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(dayOfWeek.hashCode,
          $mrjc(start.hashCode, $mrjc(end.hashCode, location.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Period &&
          other.id == id &&
          other.dayOfWeek == dayOfWeek &&
          other.start == start &&
          other.end == end &&
          other.location == location);
}

class PeriodsCompanion extends UpdateCompanion<Period> {
  final Value<int> id;
  final Value<int> dayOfWeek;
  final Value<DateTime> start;
  final Value<DateTime> end;
  final Value<String> location;
  const PeriodsCompanion({
    this.id = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.location = const Value.absent(),
  });
  PeriodsCompanion copyWith(
      {Value<int> id,
      Value<int> dayOfWeek,
      Value<DateTime> start,
      Value<DateTime> end,
      Value<String> location}) {
    return PeriodsCompanion(
      id: id ?? this.id,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      start: start ?? this.start,
      end: end ?? this.end,
      location: location ?? this.location,
    );
  }
}

class $PeriodsTable extends Periods with TableInfo<$PeriodsTable, Period> {
  final GeneratedDatabase _db;
  final String _alias;
  $PeriodsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false, hasAutoIncrement: true);
  }

  final VerificationMeta _dayOfWeekMeta = const VerificationMeta('dayOfWeek');
  GeneratedIntColumn _dayOfWeek;
  @override
  GeneratedIntColumn get dayOfWeek => _dayOfWeek ??= _constructDayOfWeek();
  GeneratedIntColumn _constructDayOfWeek() {
    return GeneratedIntColumn('day_of_week', $tableName, false,
        $customConstraints: 'field in (1, 7');
  }

  final VerificationMeta _startMeta = const VerificationMeta('start');
  GeneratedDateTimeColumn _start;
  @override
  GeneratedDateTimeColumn get start => _start ??= _constructStart();
  GeneratedDateTimeColumn _constructStart() {
    return GeneratedDateTimeColumn(
      'start',
      $tableName,
      true,
    );
  }

  final VerificationMeta _endMeta = const VerificationMeta('end');
  GeneratedDateTimeColumn _end;
  @override
  GeneratedDateTimeColumn get end => _end ??= _constructEnd();
  GeneratedDateTimeColumn _constructEnd() {
    return GeneratedDateTimeColumn(
      'end',
      $tableName,
      true,
    );
  }

  final VerificationMeta _locationMeta = const VerificationMeta('location');
  GeneratedTextColumn _location;
  @override
  GeneratedTextColumn get location => _location ??= _constructLocation();
  GeneratedTextColumn _constructLocation() {
    return GeneratedTextColumn('location', $tableName, true,
        minTextLength: 1, maxTextLength: 50);
  }

  @override
  List<GeneratedColumn> get $columns => [id, dayOfWeek, start, end, location];
  @override
  $PeriodsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'periods';
  @override
  final String actualTableName = 'periods';
  @override
  VerificationContext validateIntegrity(PeriodsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.dayOfWeek.present) {
      context.handle(_dayOfWeekMeta,
          dayOfWeek.isAcceptableValue(d.dayOfWeek.value, _dayOfWeekMeta));
    } else if (dayOfWeek.isRequired && isInserting) {
      context.missing(_dayOfWeekMeta);
    }
    if (d.start.present) {
      context.handle(
          _startMeta, start.isAcceptableValue(d.start.value, _startMeta));
    } else if (start.isRequired && isInserting) {
      context.missing(_startMeta);
    }
    if (d.end.present) {
      context.handle(_endMeta, end.isAcceptableValue(d.end.value, _endMeta));
    } else if (end.isRequired && isInserting) {
      context.missing(_endMeta);
    }
    if (d.location.present) {
      context.handle(_locationMeta,
          location.isAcceptableValue(d.location.value, _locationMeta));
    } else if (location.isRequired && isInserting) {
      context.missing(_locationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Period map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Period.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(PeriodsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.dayOfWeek.present) {
      map['day_of_week'] = Variable<int, IntType>(d.dayOfWeek.value);
    }
    if (d.start.present) {
      map['start'] = Variable<DateTime, DateTimeType>(d.start.value);
    }
    if (d.end.present) {
      map['end'] = Variable<DateTime, DateTimeType>(d.end.value);
    }
    if (d.location.present) {
      map['location'] = Variable<String, StringType>(d.location.value);
    }
    return map;
  }

  @override
  $PeriodsTable createAlias(String alias) {
    return $PeriodsTable(_db, alias);
  }
}

class Timetable extends DataClass implements Insertable<Timetable> {
  final int id;
  final String title;
  final DateTime start;
  final DateTime end;
  final String description;
  Timetable(
      {@required this.id,
      @required this.title,
      @required this.start,
      @required this.end,
      this.description});
  factory Timetable.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Timetable(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      start:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}start']),
      end: dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}end']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
    );
  }
  factory Timetable.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Timetable(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      start: serializer.fromJson<DateTime>(json['start']),
      end: serializer.fromJson<DateTime>(json['end']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'start': serializer.toJson<DateTime>(start),
      'end': serializer.toJson<DateTime>(end),
      'description': serializer.toJson<String>(description),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Timetable>>(bool nullToAbsent) {
    return TimetablesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      start:
          start == null && nullToAbsent ? const Value.absent() : Value(start),
      end: end == null && nullToAbsent ? const Value.absent() : Value(end),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    ) as T;
  }

  Timetable copyWith(
          {int id,
          String title,
          DateTime start,
          DateTime end,
          String description}) =>
      Timetable(
        id: id ?? this.id,
        title: title ?? this.title,
        start: start ?? this.start,
        end: end ?? this.end,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('Timetable(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(title.hashCode,
          $mrjc(start.hashCode, $mrjc(end.hashCode, description.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Timetable &&
          other.id == id &&
          other.title == title &&
          other.start == start &&
          other.end == end &&
          other.description == description);
}

class TimetablesCompanion extends UpdateCompanion<Timetable> {
  final Value<int> id;
  final Value<String> title;
  final Value<DateTime> start;
  final Value<DateTime> end;
  final Value<String> description;
  const TimetablesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.description = const Value.absent(),
  });
  TimetablesCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<DateTime> start,
      Value<DateTime> end,
      Value<String> description}) {
    return TimetablesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      start: start ?? this.start,
      end: end ?? this.end,
      description: description ?? this.description,
    );
  }
}

class $TimetablesTable extends Timetables
    with TableInfo<$TimetablesTable, Timetable> {
  final GeneratedDatabase _db;
  final String _alias;
  $TimetablesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false, hasAutoIncrement: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _startMeta = const VerificationMeta('start');
  GeneratedDateTimeColumn _start;
  @override
  GeneratedDateTimeColumn get start => _start ??= _constructStart();
  GeneratedDateTimeColumn _constructStart() {
    return GeneratedDateTimeColumn(
      'start',
      $tableName,
      false,
    );
  }

  final VerificationMeta _endMeta = const VerificationMeta('end');
  GeneratedDateTimeColumn _end;
  @override
  GeneratedDateTimeColumn get end => _end ??= _constructEnd();
  GeneratedDateTimeColumn _constructEnd() {
    return GeneratedDateTimeColumn(
      'end',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, true,
        minTextLength: 1, maxTextLength: 255);
  }

  @override
  List<GeneratedColumn> get $columns => [id, title, start, end, description];
  @override
  $TimetablesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'timetables';
  @override
  final String actualTableName = 'timetables';
  @override
  VerificationContext validateIntegrity(TimetablesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.start.present) {
      context.handle(
          _startMeta, start.isAcceptableValue(d.start.value, _startMeta));
    } else if (start.isRequired && isInserting) {
      context.missing(_startMeta);
    }
    if (d.end.present) {
      context.handle(_endMeta, end.isAcceptableValue(d.end.value, _endMeta));
    } else if (end.isRequired && isInserting) {
      context.missing(_endMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    } else if (description.isRequired && isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Timetable map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Timetable.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TimetablesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.start.present) {
      map['start'] = Variable<DateTime, DateTimeType>(d.start.value);
    }
    if (d.end.present) {
      map['end'] = Variable<DateTime, DateTimeType>(d.end.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    return map;
  }

  @override
  $TimetablesTable createAlias(String alias) {
    return $TimetablesTable(_db, alias);
  }
}

class Subject extends DataClass implements Insertable<Subject> {
  final int id;
  final String title;
  final int color;
  final String teacher;
  final String description;
  Subject(
      {@required this.id,
      @required this.title,
      @required this.color,
      @required this.teacher,
      @required this.description});
  factory Subject.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Subject(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      color: intType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
      teacher:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}teacher']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
    );
  }
  factory Subject.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Subject(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      color: serializer.fromJson<int>(json['color']),
      teacher: serializer.fromJson<String>(json['teacher']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'color': serializer.toJson<int>(color),
      'teacher': serializer.toJson<String>(teacher),
      'description': serializer.toJson<String>(description),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Subject>>(bool nullToAbsent) {
    return SubjectsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      teacher: teacher == null && nullToAbsent
          ? const Value.absent()
          : Value(teacher),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    ) as T;
  }

  Subject copyWith(
          {int id,
          String title,
          int color,
          String teacher,
          String description}) =>
      Subject(
        id: id ?? this.id,
        title: title ?? this.title,
        color: color ?? this.color,
        teacher: teacher ?? this.teacher,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('color: $color, ')
          ..write('teacher: $teacher, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              color.hashCode, $mrjc(teacher.hashCode, description.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == id &&
          other.title == title &&
          other.color == color &&
          other.teacher == teacher &&
          other.description == description);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> color;
  final Value<String> teacher;
  final Value<String> description;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.color = const Value.absent(),
    this.teacher = const Value.absent(),
    this.description = const Value.absent(),
  });
  SubjectsCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<int> color,
      Value<String> teacher,
      Value<String> description}) {
    return SubjectsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      teacher: teacher ?? this.teacher,
      description: description ?? this.description,
    );
  }
}

class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  final GeneratedDatabase _db;
  final String _alias;
  $SubjectsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false, hasAutoIncrement: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedIntColumn _color;
  @override
  GeneratedIntColumn get color => _color ??= _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn(
      'color',
      $tableName,
      false,
    );
  }

  final VerificationMeta _teacherMeta = const VerificationMeta('teacher');
  GeneratedTextColumn _teacher;
  @override
  GeneratedTextColumn get teacher => _teacher ??= _constructTeacher();
  GeneratedTextColumn _constructTeacher() {
    return GeneratedTextColumn('teacher', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, false,
        minTextLength: 1, maxTextLength: 255);
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, color, teacher, description];
  @override
  $SubjectsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'subjects';
  @override
  final String actualTableName = 'subjects';
  @override
  VerificationContext validateIntegrity(SubjectsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.color.present) {
      context.handle(
          _colorMeta, color.isAcceptableValue(d.color.value, _colorMeta));
    } else if (color.isRequired && isInserting) {
      context.missing(_colorMeta);
    }
    if (d.teacher.present) {
      context.handle(_teacherMeta,
          teacher.isAcceptableValue(d.teacher.value, _teacherMeta));
    } else if (teacher.isRequired && isInserting) {
      context.missing(_teacherMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    } else if (description.isRequired && isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subject map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Subject.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SubjectsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.color.present) {
      map['color'] = Variable<int, IntType>(d.color.value);
    }
    if (d.teacher.present) {
      map['teacher'] = Variable<String, StringType>(d.teacher.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    return map;
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $PeriodsTable _periods;
  $PeriodsTable get periods => _periods ??= $PeriodsTable(this);
  $TimetablesTable _timetables;
  $TimetablesTable get timetables => _timetables ??= $TimetablesTable(this);
  $SubjectsTable _subjects;
  $SubjectsTable get subjects => _subjects ??= $SubjectsTable(this);
  PeriodDao _periodDao;
  PeriodDao get periodDao => _periodDao ??= PeriodDao(this as AppDatabase);
  TimetableDao _timetableDao;
  TimetableDao get timetableDao =>
      _timetableDao ??= TimetableDao(this as AppDatabase);
  SubjectDao _subjectDao;
  SubjectDao get subjectDao => _subjectDao ??= SubjectDao(this as AppDatabase);
  @override
  List<TableInfo> get allTables => [periods, timetables, subjects];
}
