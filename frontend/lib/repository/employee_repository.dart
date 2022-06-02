import 'package:frontend/data_Providers/employee_data_provider.dart';
import 'package:frontend/models/Employee.dart';

class EmployeeRepository {
  final EmployeeDataProvider companyDataProvider = EmployeeDataProvider();

  Future<Employee> fetchSingle() async {
    try {
      return await EmployeeDataProvider.fetchSingle();
    } catch (e) {
      rethrow;
    }
  }


}
