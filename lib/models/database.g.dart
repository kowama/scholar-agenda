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
  final int timetableId;
  final int subjectId;
  PeriodDataClass(
      {@required this.id,
      @required this.dayOfWeek,
      @required this.start,
      @required this.end,
      @required this.location,
      @required this.timetableId,
      @required this.subjectId});
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
      timetableId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}timetable_id']),
      subjectId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}subject_id']),
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
      timetableId: serializer.fromJson<int>(json['timetableId']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
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
      'timetableId': serializer.toJson<int>(timetableId),
      'subjectId': serializer.toJson<int>(subjectId),
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
      timetableId: timetableId == null && nullToAbsent
          ? const Value.absent()
          : Value(timetableId),
      subjectId: subjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(subjectId),
    ) as T;
  }

  PeriodDataClass copyWith(
          {int id,
          int dayOfWeek,
          DateTime start,
          DateTime end,
          String location,
          int timetableId,
          int subjectId}) =>
      PeriodDataClass(
        id: id ?? this.id,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        start: start ?? this.start,
        end: end ?? this.end,
        location: location ?? this.location,
        timetableId: timetableId ?? this.timetableId,
        subjectId: subjectId ?? this.subjectId,
      );
  @override
  String toString() {
    return (StringBuffer('PeriodDataClass(')
          ..write('id: $id, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('location: $location, ')
          ..write('timetableId: $timetableId, ')
          ..write('subjectId: $subjectId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          dayOfWeek.hashCode,
          $mrjc(
              start.hashCode,
              $mrjc(
                  end.hashCode,
                  $mrjc(location.hashCode,
                      $mrjc(timetableId.hashCode, subjectId.hashCode)))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is PeriodDataClass &&
          other.id == id &&
          other.dayOfWeek == dayOfWeek &&
          other.start == start &&
          other.end == end &&
          other.location == location &&
          other.timetableId == timetableId &&
          other.subjectId == subjectId);
}

class PeriodsCompanion extends UpdateCompanion<PeriodDataClass> {
  final Value<int> id;
  final Value<int> dayOfWeek;
  final Value<DateTime> start;
  final Value<DateTime> end;
  final Value<String> location;
  final Value<int> timetableId;
  final Value<int> subjectId;
  const PeriodsCompanion({
    this.id = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.location = const Value.absent(),
    this.timetableId = const Value.absent(),
    this.subjectId = const Value.absent(),
  });
  PeriodsCompanion copyWith(
      {Value<int> id,
      Value<int> dayOfWeek,
      Value<DateTime> start,
      Value<DateTime> end,
      Value<String> location,
      Value<int> timetableId,
      Value<int> subjectId}) {
    return PeriodsCompanion(
      id: id ?? this.id,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      start: start ?? this.start,
      end: end ?? this.end,
      location: location ?? this.location,
      timetableId: timetableId ?? this.timetableId,
      subjectId: subjectId ?? this.subjectId,
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
    return GeneratedTextColumn('location', $tableName, false,
        minTextLength: 0, maxTextLength: 50);
  }

  final VerificationMeta _timetableIdMeta =
      const VerificationMeta('timetableId');
  GeneratedIntColumn _timetableId;
  @override
  GeneratedIntColumn get timetableId =>
      _timetableId ??= _constructTimetableId();
  GeneratedIntColumn _constructTimetableId() {
    return GeneratedIntColumn('timetable_id', $tableName, false,
        $customConstraints: 'REFERENCES timetables(id)');
  }

  final VerificationMeta _subjectIdMeta = const VerificationMeta('subjectId');
  GeneratedIntColumn _subjectId;
  @override
  GeneratedIntColumn get subjectId => _subjectId ??= _constructSubjectId();
  GeneratedIntColumn _constructSubjectId() {
    return GeneratedIntColumn('subject_id', $tableName, false,
        $customConstraints: 'REFERENCES subjects(id)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, dayOfWeek, start, end, location, timetableId, subjectId];
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
    if (d.timetableId.present) {
      context.handle(_timetableIdMeta,
          timetableId.isAcceptableValue(d.timetableId.value, _timetableIdMeta));
    } else if (timetableId.isRequired && isInserting) {
      context.missing(_timetableIdMeta);
    }
    if (d.subjectId.present) {
      context.handle(_subjectIdMeta,
          subjectId.isAcceptableValue(d.subjectId.value, _subjectIdMeta));
    } else if (subjectId.isRequired && isInserting) {
      context.missing(_subjectIdMeta);
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
    if (d.timetableId.present) {
      map['timetable_id'] = Variable<int, IntType>(d.timetableId.value);
    }
    if (d.subjectId.present) {
      map['subject_id'] = Variable<int, IntType>(d.subjectId.value);
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
      @required this.description});
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
    return GeneratedTextColumn('description', $tableName, false,
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
      @required this.teacher,
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
    return GeneratedTextColumn('teacher', $tableName, false,
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

class EventDataClass extends DataClass implements Insertable<EventDataClass> {
  final int id;
  final String title;
  final int typeValue;
  final DateTime date;
  final DateTime remindMeAt;
  final DateTime start;
  final DateTime end;
  final int repeatModeValue;
  final String note;
  final int subjectId;
  EventDataClass(
      {@required this.id,
      @required this.title,
      @required this.typeValue,
      @required this.date,
      this.remindMeAt,
      this.start,
      this.end,
      @required this.repeatModeValue,
      @required this.note,
      this.subjectId});
  factory EventDataClass.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return EventDataClass(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      typeValue:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}type_value']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      remindMeAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}remind_me_at']),
      start:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}start']),
      end: dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}end']),
      repeatModeValue: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}repeat_mode_value']),
      note: stringType.mapFromDatabaseResponse(data['${effectivePrefix}note']),
      subjectId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}subject_id']),
    );
  }
  factory EventDataClass.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return EventDataClass(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      typeValue: serializer.fromJson<int>(json['typeValue']),
      date: serializer.fromJson<DateTime>(json['date']),
      remindMeAt: serializer.fromJson<DateTime>(json['remindMeAt']),
      start: serializer.fromJson<DateTime>(json['start']),
      end: serializer.fromJson<DateTime>(json['end']),
      repeatModeValue: serializer.fromJson<int>(json['repeatModeValue']),
      note: serializer.fromJson<String>(json['note']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'typeValue': serializer.toJson<int>(typeValue),
      'date': serializer.toJson<DateTime>(date),
      'remindMeAt': serializer.toJson<DateTime>(remindMeAt),
      'start': serializer.toJson<DateTime>(start),
      'end': serializer.toJson<DateTime>(end),
      'repeatModeValue': serializer.toJson<int>(repeatModeValue),
      'note': serializer.toJson<String>(note),
      'subjectId': serializer.toJson<int>(subjectId),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<EventDataClass>>(
      bool nullToAbsent) {
    return EventsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      typeValue: typeValue == null && nullToAbsent
          ? const Value.absent()
          : Value(typeValue),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      remindMeAt: remindMeAt == null && nullToAbsent
          ? const Value.absent()
          : Value(remindMeAt),
      start:
          start == null && nullToAbsent ? const Value.absent() : Value(start),
      end: end == null && nullToAbsent ? const Value.absent() : Value(end),
      repeatModeValue: repeatModeValue == null && nullToAbsent
          ? const Value.absent()
          : Value(repeatModeValue),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      subjectId: subjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(subjectId),
    ) as T;
  }

  EventDataClass copyWith(
          {int id,
          String title,
          int typeValue,
          DateTime date,
          DateTime remindMeAt,
          DateTime start,
          DateTime end,
          int repeatModeValue,
          String note,
          int subjectId}) =>
      EventDataClass(
        id: id ?? this.id,
        title: title ?? this.title,
        typeValue: typeValue ?? this.typeValue,
        date: date ?? this.date,
        remindMeAt: remindMeAt ?? this.remindMeAt,
        start: start ?? this.start,
        end: end ?? this.end,
        repeatModeValue: repeatModeValue ?? this.repeatModeValue,
        note: note ?? this.note,
        subjectId: subjectId ?? this.subjectId,
      );
  @override
  String toString() {
    return (StringBuffer('EventDataClass(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('typeValue: $typeValue, ')
          ..write('date: $date, ')
          ..write('remindMeAt: $remindMeAt, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('repeatModeValue: $repeatModeValue, ')
          ..write('note: $note, ')
          ..write('subjectId: $subjectId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              typeValue.hashCode,
              $mrjc(
                  date.hashCode,
                  $mrjc(
                      remindMeAt.hashCode,
                      $mrjc(
                          start.hashCode,
                          $mrjc(
                              end.hashCode,
                              $mrjc(
                                  repeatModeValue.hashCode,
                                  $mrjc(note.hashCode,
                                      subjectId.hashCode))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is EventDataClass &&
          other.id == id &&
          other.title == title &&
          other.typeValue == typeValue &&
          other.date == date &&
          other.remindMeAt == remindMeAt &&
          other.start == start &&
          other.end == end &&
          other.repeatModeValue == repeatModeValue &&
          other.note == note &&
          other.subjectId == subjectId);
}

class EventsCompanion extends UpdateCompanion<EventDataClass> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> typeValue;
  final Value<DateTime> date;
  final Value<DateTime> remindMeAt;
  final Value<DateTime> start;
  final Value<DateTime> end;
  final Value<int> repeatModeValue;
  final Value<String> note;
  final Value<int> subjectId;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.typeValue = const Value.absent(),
    this.date = const Value.absent(),
    this.remindMeAt = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.repeatModeValue = const Value.absent(),
    this.note = const Value.absent(),
    this.subjectId = const Value.absent(),
  });
  EventsCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<int> typeValue,
      Value<DateTime> date,
      Value<DateTime> remindMeAt,
      Value<DateTime> start,
      Value<DateTime> end,
      Value<int> repeatModeValue,
      Value<String> note,
      Value<int> subjectId}) {
    return EventsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      typeValue: typeValue ?? this.typeValue,
      date: date ?? this.date,
      remindMeAt: remindMeAt ?? this.remindMeAt,
      start: start ?? this.start,
      end: end ?? this.end,
      repeatModeValue: repeatModeValue ?? this.repeatModeValue,
      note: note ?? this.note,
      subjectId: subjectId ?? this.subjectId,
    );
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, EventDataClass> {
  final GeneratedDatabase _db;
  final String _alias;
  $EventsTable(this._db, [this._alias]);
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

  final VerificationMeta _typeValueMeta = const VerificationMeta('typeValue');
  GeneratedIntColumn _typeValue;
  @override
  GeneratedIntColumn get typeValue => _typeValue ??= _constructTypeValue();
  GeneratedIntColumn _constructTypeValue() {
    return GeneratedIntColumn(
      'type_value',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _remindMeAtMeta = const VerificationMeta('remindMeAt');
  GeneratedDateTimeColumn _remindMeAt;
  @override
  GeneratedDateTimeColumn get remindMeAt =>
      _remindMeAt ??= _constructRemindMeAt();
  GeneratedDateTimeColumn _constructRemindMeAt() {
    return GeneratedDateTimeColumn(
      'remind_me_at',
      $tableName,
      true,
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

  final VerificationMeta _repeatModeValueMeta =
      const VerificationMeta('repeatModeValue');
  GeneratedIntColumn _repeatModeValue;
  @override
  GeneratedIntColumn get repeatModeValue =>
      _repeatModeValue ??= _constructRepeatModeValue();
  GeneratedIntColumn _constructRepeatModeValue() {
    return GeneratedIntColumn(
      'repeat_mode_value',
      $tableName,
      false,
    );
  }

  final VerificationMeta _noteMeta = const VerificationMeta('note');
  GeneratedTextColumn _note;
  @override
  GeneratedTextColumn get note => _note ??= _constructNote();
  GeneratedTextColumn _constructNote() {
    return GeneratedTextColumn('note', $tableName, false,
        minTextLength: 0, maxTextLength: 128);
  }

  final VerificationMeta _subjectIdMeta = const VerificationMeta('subjectId');
  GeneratedIntColumn _subjectId;
  @override
  GeneratedIntColumn get subjectId => _subjectId ??= _constructSubjectId();
  GeneratedIntColumn _constructSubjectId() {
    return GeneratedIntColumn('subject_id', $tableName, true,
        $customConstraints: 'REFERENCES subjects(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        typeValue,
        date,
        remindMeAt,
        start,
        end,
        repeatModeValue,
        note,
        subjectId
      ];
  @override
  $EventsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'events';
  @override
  final String actualTableName = 'events';
  @override
  VerificationContext validateIntegrity(EventsCompanion d,
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
    if (d.typeValue.present) {
      context.handle(_typeValueMeta,
          typeValue.isAcceptableValue(d.typeValue.value, _typeValueMeta));
    } else if (typeValue.isRequired && isInserting) {
      context.missing(_typeValueMeta);
    }
    if (d.date.present) {
      context.handle(
          _dateMeta, date.isAcceptableValue(d.date.value, _dateMeta));
    } else if (date.isRequired && isInserting) {
      context.missing(_dateMeta);
    }
    if (d.remindMeAt.present) {
      context.handle(_remindMeAtMeta,
          remindMeAt.isAcceptableValue(d.remindMeAt.value, _remindMeAtMeta));
    } else if (remindMeAt.isRequired && isInserting) {
      context.missing(_remindMeAtMeta);
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
    if (d.repeatModeValue.present) {
      context.handle(
          _repeatModeValueMeta,
          repeatModeValue.isAcceptableValue(
              d.repeatModeValue.value, _repeatModeValueMeta));
    } else if (repeatModeValue.isRequired && isInserting) {
      context.missing(_repeatModeValueMeta);
    }
    if (d.note.present) {
      context.handle(
          _noteMeta, note.isAcceptableValue(d.note.value, _noteMeta));
    } else if (note.isRequired && isInserting) {
      context.missing(_noteMeta);
    }
    if (d.subjectId.present) {
      context.handle(_subjectIdMeta,
          subjectId.isAcceptableValue(d.subjectId.value, _subjectIdMeta));
    } else if (subjectId.isRequired && isInserting) {
      context.missing(_subjectIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventDataClass map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return EventDataClass.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(EventsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.typeValue.present) {
      map['type_value'] = Variable<int, IntType>(d.typeValue.value);
    }
    if (d.date.present) {
      map['date'] = Variable<DateTime, DateTimeType>(d.date.value);
    }
    if (d.remindMeAt.present) {
      map['remind_me_at'] =
          Variable<DateTime, DateTimeType>(d.remindMeAt.value);
    }
    if (d.start.present) {
      map['start'] = Variable<DateTime, DateTimeType>(d.start.value);
    }
    if (d.end.present) {
      map['end'] = Variable<DateTime, DateTimeType>(d.end.value);
    }
    if (d.repeatModeValue.present) {
      map['repeat_mode_value'] =
          Variable<int, IntType>(d.repeatModeValue.value);
    }
    if (d.note.present) {
      map['note'] = Variable<String, StringType>(d.note.value);
    }
    if (d.subjectId.present) {
      map['subject_id'] = Variable<int, IntType>(d.subjectId.value);
    }
    return map;
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(_db, alias);
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
  $EventsTable _events;
  $EventsTable get events => _events ??= $EventsTable(this);
  PeriodDao _periodDao;
  PeriodDao get periodDao =>
      _periodDao ??= PeriodDao(this as ScholarAgendaAppDb);
  TimetableDao _timetableDao;
  TimetableDao get timetableDao =>
      _timetableDao ??= TimetableDao(this as ScholarAgendaAppDb);
  SubjectDao _subjectDao;
  SubjectDao get subjectDao =>
      _subjectDao ??= SubjectDao(this as ScholarAgendaAppDb);
  EventDao _eventDao;
  EventDao get eventDao => _eventDao ??= EventDao(this as ScholarAgendaAppDb);
  @override
  List<TableInfo> get allTables => [periods, timetables, subjects, events];
}
