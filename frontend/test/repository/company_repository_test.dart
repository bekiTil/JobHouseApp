import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/Company.dart';
import 'package:frontend/models/company_profile.dart';

void main() {
  test("The model should be able to recieve the following data", () {
    final user = Company(
      "12",
      "First Last",
      "fakeUsername",
      'fakeEmail@gmail.com',
      'company',
      CompanyProfile('Addis Ababa', 'some description'),
    );

    CompanyProfile cmp = user.companyProfile;
    expect(user.id, "12");
    expect(user.fullName, "First Last");
    expect(user.username, "fakeUsername");
    expect(user.email, "fakeEmail@gmail.com");
    expect(user.role, 'company');
    expect(cmp.location, "Addis Ababa");
    expect(cmp.bio, 'some description');
  });
}
