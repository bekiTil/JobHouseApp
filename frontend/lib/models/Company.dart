import 'models.dart';
class Company {
  final String id;
  final String fullName;
  final String username;
  final String email;
  final String role;
  late CompanyProfile companyProfile;

  Company(this.id, this.fullName, this.username, this.email, this.role, this.companyProfile);
}
