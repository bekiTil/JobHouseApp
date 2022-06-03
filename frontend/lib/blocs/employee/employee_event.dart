part of 'employee_bloc.dart';

@immutable
abstract class EmployeeEvent {}

class EmployeeHomeVisited extends EmployeeEvent {

  EmployeeHomeVisited();
  
}

class DeleteEmployee extends EmployeeEvent{
  
  final String userName;
  DeleteEmployee(this.userName);
}
