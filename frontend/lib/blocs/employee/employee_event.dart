part of 'employee_bloc.dart';

@immutable
abstract class EmployeeEvent {}

class EmployeeHomeVisited extends EmployeeEvent {
  final String id;

  EmployeeHomeVisited(this.id);
  
}
