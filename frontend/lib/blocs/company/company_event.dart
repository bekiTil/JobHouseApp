part of 'company_bloc.dart';

@immutable
abstract class CompanyEvent {}

class CompanyHomeVisited extends CompanyEvent {
  
}

class DeleteCompany extends CompanyEvent{
  String userName;

  DeleteCompany(this.userName);
}