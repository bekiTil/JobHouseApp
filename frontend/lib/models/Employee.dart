import 'models.dart';
class Employee {
  final String id;
  final String fullName;
  final String username;
  final String email;
  final String role;
  final EmployeeProfile employeeProfile;

  Employee(this.id, this.fullName, this.username, this.email, this.role,
      this.employeeProfile);
}
