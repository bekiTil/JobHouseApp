import 'employee_profile.dart';

class Employee {
  final String id;
  final String fullName;
  final String username;
  final String email;
  final String role;
  final EmployeeProfile employeeProfile;

  Employee(this.id, this.fullName, this.username, this.email, this.role,
      this.employeeProfile);

  factory Employee.fromJson(Map<String, dynamic> json) {
    EmployeeProfile emp = EmployeeProfile.fromJson(json['profile']);
    return Employee(
      json['id'],
      json['fullName'],
      json['username'],
      json['email'],
      json['role'],
      emp,
    );
  }
}
