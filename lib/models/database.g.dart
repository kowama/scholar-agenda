// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class PeriodDataClass extends DataClass implements Insertable<PeriodDataClass> {
  final int id;
  final int dayOfWeek;
  final DateTime start;
  final DateTime end;
  final String location;
  PeriodDataClass(
      {@required this.id,
      @required this.dayOfWeek,
      @required this.start,
      @required this.end,
      this.location});
  factory PeriodDataClass.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    return PeriodDataClass(
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
  factory PeriodDataClass.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return PeriodDataClass(
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
  T createCompanion<T extends UpdateCompanion<PeriodDataClass>>(
      bool nullToAbsent) {
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

  PeriodDataClass copyWith(
          {int id,
          int dayOfWeek,
          DateTime start,
          DateTime end,
          String location}) =>
      PeriodDataClass(
        id: id ?? this.id,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        start: start ?? this.start,
        end: end ?? this.end,
        location: location ?? this.location,
      );
  @override
  String toString() {
    return (StringBuffer('PeriodDataClass(')
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
      (other is PeriodDataClass &&
          other.id == id &&
          other.dayOfWeek == dayOfWeek &&
          other.start == start &&
          other.end == end &&
          other.location == location);
}

class PeriodsCompanion extends UpdateCompanion<PeriodDataClass> {
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

class $PeriodsTable extends Periods
    with TableInfo<$PeriodsTable, PeriodDataClass> {
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
    return GeneratedIntColumn(
      'day_of_week',
      $tableName,
      false,
    );
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

  final VerificationMeta _locationMeta = const VerificationMeta('location');
  GeneratedTextColumn _location;
  @override
  GeneratedTextColumn get location => _location ??= _constructLocation();
  GeneratedTextColumn _constructLocation() {
    return GeneratedTextColumn('location', $tableName, true,
        minTextLength: 0, maxTextLength: 50);
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
  PeriodDataClass map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PeriodDataClass.fromData(data, _db, prefix: effectivePrefix);
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

class TimetableDataClass extends DataClass
    implements Insertable<TimetableDataClass> {
  final int id;
  final String title;
  final DateTime start;
  final DateTime end;
  final String description;
  TimetableDataClass(
      {@required this.id,
      @required this.title,
      @required this.start,
      @required this.end,
      this.description});
  factory TimetableDataClass.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return TimetableDataClass(
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
  factory TimetableDataClass.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return TimetableDataClass(
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
  T createCompanion<T extends UpdateCompanion<TimetableDataClass>>(
      bool nullToAbsent) {
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

  TimetableDataClass copyWith(
          {int id,
          String title,
          DateTime start,
          DateTime end,
          String description}) =>
      TimetableDataClass(
        id: id ?? this.id,
        title: title ?? this.title,
        start: start ?? this.start,
        end: end ?? this.end,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('TimetableDataClass(')
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
      (other is TimetableDataClass &&
          other.id == id &&
          other.title == title &&
          other.start == start &&
          other.end == end &&
          other.description == description);
}

class TimetablesCompanion extends UpdateCompanion<TimetableDataClass> {
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
    with TableInfo<$TimetablesTable, TimetableDataClass> {
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
        minTextLength: 0, maxTextLength: 255);
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
  TimetableDataClass map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TimetableDataClass.fromData(data, _db, prefix: effectivePrefix);
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

class SubjectDataClass extends DataClass
    implements Insertable<SubjectDataClass> {
  final int id;
  final String title;
  final int colorValue;
  final String teacher;
  final String description;
  SubjectDataClass(
      {@required this.id,
      @required this.title,
      @required this.colorValue,
      this.teacher,
      this.description});
  factory SubjectDataClass.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return SubjectDataClass(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      colorValue: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}color_value']),
      teacher:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}teacher']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
    );
  }
  factory SubjectDataClass.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return SubjectDataClass(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
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
      'colorValue': serializer.toJson<int>(colorValue),
      'teacher': serializer.toJson<String>(teacher),
      'description': serializer.toJson<String>(description),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<SubjectDataClass>>(
      bool nullToAbsent) {
    return SubjectsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      colorValue: colorValue == null && nullToAbsent
          ? const Value.absent()
          : Value(colorValue),
      teacher: teacher == null && nullToAbsent
          ? const Value.absent()
          : Value(teacher),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    ) as T;
  }

  SubjectDataClass copyWith(
          {int id,
          String title,
          int colorValue,
          String teacher,
          String description}) =>
      SubjectDataClass(
        id: id ?? this.id,
        title: title ?? this.title,
        colorValue: colorValue ?? this.colorValue,
        teacher: teacher ?? this.teacher,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('SubjectDataClass(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('colorValue: $colorValue, ')
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
          $mrjc(colorValue.hashCode,
              $mrjc(teacher.hashCode, description.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is SubjectDataClass &&
          other.id == id &&
          other.title == title &&
          other.colorValue == colorValue &&
          other.teacher == teacher &&
          other.description == description);
}

class SubjectsCompanion extends UpdateCompanion<SubjectDataClass> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> colorValue;
  final Value<String> teacher;
  final Value<String> description;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.teacher = const Value.absent(),
    this.description = const Value.absent(),
  });
  SubjectsCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<int> colorValue,
      Value<String> teacher,
      Value<String> description}) {
    return SubjectsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      colorValue: colorValue ?? this.colorValue,
      teacher: teacher ?? this.teacher,
      description: description ?? this.description,
    );
  }
}

class $SubjectsTable extends Subjects
    with TableInfo<$SubjectsTable, SubjectDataClass> {
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

  final VerificationMeta _colorValueMeta = const VerificationMeta('colorValue');
  GeneratedIntColumn _colorValue;
  @override
  GeneratedIntColumn get colorValue => _colorValue ??= _constructColorValue();
  GeneratedIntColumn _constructColorValue() {
    return GeneratedIntColumn(
      'color_value',
      $tableName,
      false,
    );
  }

  final VerificationMeta _teacherMeta = const VerificationMeta('teacher');
  GeneratedTextColumn _teacher;
  @override
  GeneratedTextColumn get teacher => _teacher ??= _constructTeacher();
  GeneratedTextColumn _constructTeacher() {
    return GeneratedTextColumn('teacher', $tableName, true,
        minTextLength: 0, maxTextLength: 50);
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, true,
        minTextLength: 0, maxTextLength: 255);
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, colorValue, teacher, description];
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
    if (d.colorValue.present) {
      context.handle(_colorValueMeta,
          colorValue.isAcceptableValue(d.colorValue.value, _colorValueMeta));
    } else if (colorValue.isRequired && isInserting) {
      context.missing(_colorValueMeta);
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
  SubjectDataClass map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SubjectDataClass.fromData(data, _db, prefix: effectivePrefix);
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
    if (d.colorValue.present) {
      map['color_value'] = Variable<int, IntType>(d.colorValue.value);
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

abstract class _$ScholarAgendaAppDb extends GeneratedDatabase {
  _$ScholarAgendaAppDb(QueryExecutor e)
      : super(const SqlTypeSystem.withDefaults(), e);
  $PeriodsTable _periods;
  $PeriodsTable get periods => _periods ??= $PeriodsTable(this);
  $TimetablesTable _timetables;
  $TimetablesTable get timetables => _timetables ??= $TimetablesTable(this);
  $SubjectsTable _subjects;
  $SubjectsTable get subjects => _subjects ??= $SubjectsTable(this);
  PeriodDao _periodDao;
  PeriodDao get periodDao =>
      _periodDao ??= PeriodDao(this as ScholarAgendaAppDb);
  TimetableDao _timetableDao;
  TimetableDao get timetableDao =>
      _timetableDao ??= TimetableDao(this as ScholarAgendaAppDb);
  SubjectDao _subjectDao;
  SubjectDao get subjectDao =>
      _subjectDao ??= SubjectDao(this as ScholarAgendaAppDb);
  @override
  List<TableInfo> get allTables => [periods, timetables, subjects];
}
