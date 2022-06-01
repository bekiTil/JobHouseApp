part of 'editcompany_bloc.dart';

@immutable
abstract class EditcompanyEvent {}

class EditCompany extends EditcompanyEvent {
  final String location;
  final String bio;
  final String token;
  final String id;
 

  EditCompany(this.location, this.bio, this.token, this.id);
}