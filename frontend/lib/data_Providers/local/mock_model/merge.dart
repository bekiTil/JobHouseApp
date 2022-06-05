import 'package:frontend/data_Providers/local/mock_model/com_profile.dart';
import 'package:frontend/data_Providers/local/mock_model/emp_profile.dart';
import 'package:frontend/data_Providers/local/mock_model/post_.dart';
import 'package:frontend/models/Company.dart';

import '../../../models/Employee.dart';
import '../../../models/bookmark.dart';
import '../../../models/company_profile.dart';
import '../../../models/employee_profile.dart';
import '../../../models/post.dart';
import 'book_mark.dart';

Employee mergeEmpProfile(MockEmpProfile mocEmp) {
  print('insideeeeeee');
  final newEmp = EmployeeProfile(
    mocEmp.fieldOfStudy!,
    mocEmp.educationLevel!,
    mocEmp.yearsOfExperience!,
    mocEmp.location!,
    mocEmp.bio!,
  );
  print(newEmp.fieldOfStudy);
  print(mocEmp.fullName!);
  print(mocEmp.id);
  print(mocEmp.username);
  print(mocEmp.email);
  print(mocEmp.role);

  final nsew = Employee(mocEmp.id!, mocEmp.fullName!, mocEmp.username!,
      mocEmp.email!, mocEmp.role!, newEmp);
  print(nsew.employeeProfile);
  return nsew;
}

Company mergeComProfile(MockCompProfile moc_emp) {
  final newComp = CompanyProfile(
    moc_emp.location!,
    moc_emp.bio!,
  );

  return Company(moc_emp.id!, moc_emp.fullName!, moc_emp.username!,
      moc_emp.email!, moc_emp.role!, newComp);
}

Bookmark mergeBookmark(
  MockBookmark mockBookmark,
) {
  return Bookmark(
      user_id: mockBookmark.user_id!,
      post_id: mockBookmark.post_id!,
      post: Post(
        category: mockBookmark.category,
        description: mockBookmark.description,
        id: mockBookmark.post_id!,
        number: mockBookmark.number,
        poster_id: '',
      ));
}
