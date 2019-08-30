import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/period.dart';

@immutable
abstract class PeriodsEvent extends Equatable {
  PeriodsEvent([List props = const <dynamic>[]]) : super(props);
}

class AddPeriod extends PeriodsEvent {
  final Period period;

  AddPeriod(this.period);

  @override
  String toString() {
    return 'AddPeriod{period: $period}';
  }
}

class UpdatePeriod extends PeriodsEvent {
  final Period period;

  UpdatePeriod(this.period);

  @override
  String toString() {
    return 'UpdatePeriod{period: $period}';
  }
}

class DeletePeriod extends PeriodsEvent {
  final Period period;

  DeletePeriod(this.period);

  @override
  String toString() {
    return 'DeletePeriod{period: $period}';
  }
}
