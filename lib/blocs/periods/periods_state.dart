import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PeriodsState extends Equatable {
  PeriodsState([List props = const <dynamic>[]]) : super(props);
}

class InitialPeriodsState extends PeriodsState {}

class PeriodsLoading extends PeriodsState {}

class PeriodsLoaded extends PeriodsState {}
