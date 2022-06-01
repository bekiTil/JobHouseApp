part of 'editEmployee_bloc.dart';

@immutable
abstract class EditEmployeeEvent {}

class EditEmployee extends EditEmployeeEvent {
  final String fieldOfStudy;
  final String educationLevel;
  final int yearsOfExperience;
  final String location;
  final String bio;
  final String token;
  final String id;
 

  EditEmployee(this.location, this.bio, this.token, this.id, this.fieldOfStudy, this.educationLevel, this.yearsOfExperience);
}