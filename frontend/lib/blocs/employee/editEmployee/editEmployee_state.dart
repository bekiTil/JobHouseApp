part of 'editEmployee_bloc.dart';

@immutable
abstract class EditEmployeeState {}

class EditEmployeeInitial extends EditEmployeeState {}

class EditingProfile extends EditEmployeeState {}

class EditProfileSuccess extends EditEmployeeState {}

class EditProfileFailed extends EditEmployeeState {
  final String exception;

  EditProfileFailed(this.exception);
}
