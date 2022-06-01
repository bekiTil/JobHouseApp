part of 'company_bloc.dart';

@immutable
abstract class CompanyEvent {}

class CompanyHomeVisited extends CompanyEvent {
  final String id;

  CompanyHomeVisited(this.id);
  
}
