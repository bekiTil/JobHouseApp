part of 'employee_bloc.dart';

@immutable
abstract class EmployeeState extends Equatable {
  final String id;
  final String username;
  final String email;
  final String fullName;
  final String location;
  final String bio;
  final String fieldOfStudy;
  final String educationLevel;
  final String yearsOfExperience;
  List<Post> posts;

  EmployeeState(
      this.username,
      this.email,
      this.fullName,
      this.location,
      this.bio,
      this.posts,
      this.id,
      this.fieldOfStudy,
      this.educationLevel,
      this.yearsOfExperience);
}

class EmployeeInitial extends EmployeeState {
  EmployeeInitial() : super(' ', ' ', ' ', ' ', ' ', [], ' ', ' ', ' ', ' ');

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmployeeHomeLoading extends EmployeeState {
  EmployeeHomeLoading()
      : super(' ', ' ', ' ', ' ', ' ', [], ' ', ' ', ' ', ' ');

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmployeeHomeLoaded extends EmployeeState {
  EmployeeHomeLoaded(
      {required String username,
      required String email,
      required String fullName,
      required String location,
      required String bio,
      required String id,
      required String fieldOfStudy,
      required String educationLevel,
      required String yearsOfExperience,
      required List<Post> posts})
      : super(username, email, fullName, location, bio, posts, id, fieldOfStudy,
            educationLevel, yearsOfExperience);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmployeeHomeLoadingFailed extends EmployeeState {
  final String exception;

  EmployeeHomeLoadingFailed({required this.exception})
      : super(' ', ' ', ' ', ' ', ' ', [], ' ', ' ', ' ', ' ');

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmployeeDeleting extends EmployeeState {
  EmployeeDeleting() : super(' ', ' ', ' ', ' ', ' ', [], ' ', ' ', ' ', ' ');

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmployeeDeletionFailed extends EmployeeState {
  final String exception;

  EmployeeDeletionFailed(this.exception)
      : super(' ', ' ', ' ', ' ', ' ', [], ' ', ' ', ' ', ' ');

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmployeeDeletionSuccess extends EmployeeState {
  EmployeeDeletionSuccess()
      : super(' ', ' ', ' ', ' ', ' ', [], ' ', ' ', ' ', ' ');

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
