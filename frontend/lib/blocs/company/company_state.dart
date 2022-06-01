part of 'company_bloc.dart';

@immutable
abstract class CompanyState {
  final String username;
  final String email;
  final String fullName;
  final String location;
  final String bio;

  const CompanyState(
      this.username, this.email, this.fullName, this.location, this.bio);
}

class CompanyInitial extends CompanyState {
  const CompanyInitial() : super(' ', ' ', ' ', ' ', ' ');
}

class CompanyHomeLoading extends CompanyState {
  const CompanyHomeLoading() : super(' ', ' ', ' ', ' ', ' ');
}

class CompanyHomeLoaded extends CompanyState {
  const CompanyHomeLoaded(
      {required String username,
      required String email,
      required String fullName,
      required String location,
      required String bio})
      : super(username, email, fullName, location, bio);
}

class CompanyHomeLoadingFailed extends CompanyState {
  final String exception;

  const CompanyHomeLoadingFailed({required this.exception})
      : super(' ', ' ', ' ', ' ', ' ');
}
