part of 'employee_bloc.dart';

@immutable
abstract class EmployeeState {
  final String username;
  final String email;
  final String fullName;
  final String location;
  final String bio;

  const EmployeeState(
      this.username, this.email, this.fullName, this.location, this.bio);
}

class EmployeeInitial extends EmployeeState {
  const EmployeeInitial() : super(' ', ' ', ' ', ' ', ' ');
}

class EmployeeHomeLoading extends EmployeeState {
  const EmployeeHomeLoading() : super(' ', ' ', ' ', ' ', ' ');
}

class EmployeeHomeLoaded extends EmployeeState {
  const EmployeeHomeLoaded(
      {required String username,
      required String email,
      required String fullName,
      required String location,
      required String bio})
      : super(username, email, fullName, location, bio);
}

class EmployeeHomeLoadingFailed extends EmployeeState {
  final String exception;

  const EmployeeHomeLoadingFailed({required this.exception})
      : super(' ', ' ', ' ', ' ', ' ');
}
