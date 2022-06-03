part of 'company_bloc.dart';

@immutable
abstract class CompanyState {
  final String username;
  final String email;
  final String fullName;
  final String location;
  final String bio;
  List<Post> posts;
  
  CompanyState(
      this.username, this.email, this.fullName, this.location, this.bio, this.posts);
}

class CompanyInitial extends CompanyState {
   CompanyInitial() : super(' ', ' ', ' ', ' ', ' ' , List.empty());
}

class CompanyHomeLoading extends CompanyState {
   CompanyHomeLoading() : super(' ', ' ', ' ', ' ', ' ', List.empty());
}

class CompanyHomeLoaded extends CompanyState {
   CompanyHomeLoaded(
      {required String username,
      required String email,
      required String fullName,
      required String location,
      required String bio,
      required List<Post> posts})
      : super(username, email, fullName, location, bio, posts);
}

class CompanyHomeLoadingFailed extends CompanyState {
  final String exception;

   CompanyHomeLoadingFailed({required this.exception})
      : super(' ', ' ', ' ', ' ', ' ', List.empty());
}
