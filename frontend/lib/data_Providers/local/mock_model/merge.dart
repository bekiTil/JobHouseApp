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
  return Employee(
      mocEmp.id!,
      mocEmp.fullName!,
      mocEmp.email!,
      mocEmp.password!,
      mocEmp.role!,
      EmployeeProfile(
        mocEmp.fieldOfStudy!,
        mocEmp.educationLevel!,
        mocEmp.yearsOfExperience!,
        mocEmp.bio!,
        mocEmp.location!,
      ));}

   Company mergeComProfile(MockCompProfile moc_emp) {
  return Company(
      moc_emp.id!,
      moc_emp.fullName!,
      moc_emp.email!,
      moc_emp.password!,
      moc_emp.role!,
      CompanyProfile(
        moc_emp.location!,
        moc_emp.bio!,
      ));
}

 Bookmark mergeBookmark(MockBookmark mockBookmark,) {
  return Bookmark(
      user_id: mockBookmark.user_id!,
      post_id: mockBookmark.post_id!,
      post: Post(
          category: mockBookmark.category,
          description: mockBookmark.description,
          id: mockBookmark.post_id!,
          number: mockBookmark.number, poster_id: '',));
}