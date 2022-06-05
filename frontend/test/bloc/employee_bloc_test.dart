import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/blocs/employee/employee_bloc.dart';
import 'package:frontend/models/Company.dart';
import 'package:frontend/models/Employee.dart';
import 'package:frontend/models/company_profile.dart';
import 'package:frontend/models/employee_profile.dart';
import 'package:frontend/repository/company_repository.dart';
import 'package:frontend/repository/employee_repository.dart';
import 'package:frontend/repository/post_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

final Employee company = Employee(
  '1',
  'NewCompany',
  'company',
  'company@gmail.com',
  'company',
  EmployeeProfile(
    "Software",
    "2",
    3,
    "Adama",
    'some bio',
  ),
);

@GenerateMocks([EmployeeRepository, PostRepository])
void main() {
  group('Employee Bloc', () {
    blocTest<EmployeeBloc, EmployeeState>(
      'emits nothing when no event is added',
      build: () => EmployeeBloc(),
      expect: () => [],
    );

    blocTest<EmployeeBloc, EmployeeState>(
      'emits [CompanyHomeLoading, CompanyHomeLoaded] when CompanyHomeVisited is added',
      build: () => EmployeeBloc(),
      act: (employeeBloc) => employeeBloc.add(EmployeeHomeVisited()),
      expect: () => [
        EmployeeHomeLoading(),
        EmployeeHomeLoadingFailed(exception: "fake exception")
      ],
    );

    blocTest<EmployeeBloc, EmployeeState>(
      'emits [CompanyHomeLoading, CompanyHomeLoadingFailed] when CompanyHomeVisited is added',
      build: () => EmployeeBloc(),
      act: (employeeBloc) => employeeBloc.add(DeleteEmployee("fakeUser")),
      expect: () => [
        EmployeeDeleting(),
        EmployeeDeletionFailed("Failed"),
      ],
    );
  });
}
