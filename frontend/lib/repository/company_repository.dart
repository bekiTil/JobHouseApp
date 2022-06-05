import 'package:frontend/data_Providers/company_data_provider.dart';
import 'package:frontend/models/Company.dart';

class CompanyRepository {
  final CompanyDataProvider companyDataProvider = CompanyDataProvider();

  Future<Company> fetchSingle() async {
    try {
      return await companyDataProvider.fetchSingle();
    } catch (e) {
      rethrow;
    }
  }

  Future edit(String location, String bio, String token, String id) async {
    try {
      await companyDataProvider.edit(location, bio, token, id);
    } catch (e) {
      rethrow;
    }
  }

  Future deleteSingle(String userName) async {
    try {
      return await CompanyDataProvider.deleteSingle(userName);
    } catch (e) {
      rethrow;
    }
  }
}
