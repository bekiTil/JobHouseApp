import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/models/Company.dart';
import 'package:frontend/models/company_profile.dart';
import 'package:frontend/repository/company_repository.dart';
import 'package:frontend/repository/post_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

final Company company = Company(
  '1',
  'NewCompany',
  'company',
  'company@gmail.com',
  'company',
  CompanyProfile("Adama", 'some bio'),
);

@GenerateMocks([CompanyRepository, PostRepository])
void main() {
  group('CompanyBloc', () {
    blocTest<CompanyBloc, CompanyState>(
      'emits nothing when no event is added',
      build: () => CompanyBloc(),
      expect: () => [],
    );

    blocTest<CompanyBloc, CompanyState>(
      'emits [CompanyHomeLoading, CompanyHomeLoaded] when CompanyHomeVisited is added',
      build: () => CompanyBloc(),
      act: (companyBloc) => companyBloc.add(CompanyHomeVisited()),
      expect: () => [
        CompanyHomeLoading(),
        CompanyHomeLoadingFailed(exception: "fake exception")
      ],
    );

    blocTest<CompanyBloc, CompanyState>(
      'emits [CompanyHomeLoading, CompanyHomeLoadingFailed] when CompanyHomeVisited is added',
      build: () => CompanyBloc(),
      act: (companyBloc) => companyBloc.add(DeleteCompany("fakeUser")),
      expect: () => [
        DeletingCompanyProfile(),
        CompanyProfileDeletionFailed(),
      ],
    );
  });
}
