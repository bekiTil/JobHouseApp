part of 'company_bloc.dart';

@immutable
abstract class CompanyState extends Equatable {
  final String username;
  final String email;
  final String fullName;
  final String location;
  final String bio;
  List<Post> posts;

  CompanyState(this.username, this.email, this.fullName, this.location,
      this.bio, this.posts);
}

class CompanyInitial extends CompanyState implements Equatable {
  CompanyInitial() : super(' ', ' ', ' ', ' ', ' ', List.empty());

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CompanyHomeLoading extends CompanyState {
  CompanyHomeLoading() : super(' ', ' ', ' ', ' ', ' ', List.empty());

  @override
  // TODO: implement props
  List<Object?> get props => [];
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

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CompanyHomeLoadingFailed extends CompanyState {
  final String exception;

  CompanyHomeLoadingFailed({required this.exception})
      : super(' ', ' ', ' ', ' ', ' ', List.empty());

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DeletingCompanyProfile extends CompanyState {
  DeletingCompanyProfile() : super(' ', ' ', ' ', ' ', ' ', List.empty());

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CompanyProfileDeletionSuccessfull extends CompanyState {
  CompanyProfileDeletionSuccessfull()
      : super(' ', ' ', ' ', ' ', ' ', List.empty());

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CompanyProfileDeletionFailed extends CompanyState {
  CompanyProfileDeletionFailed() : super(' ', ' ', ' ', ' ', ' ', List.empty());

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
