part of 'editcompany_bloc.dart';

@immutable
abstract class EditCompanyState {}

class EditcompanyInitial extends EditCompanyState {}

class EditingProfile extends EditCompanyState {}

class EditProfileSuccess extends EditCompanyState {}

class EditProfileFailed extends EditCompanyState {
  final String exception;

  EditProfileFailed(this.exception);
}
