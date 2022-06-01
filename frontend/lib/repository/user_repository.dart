import '../data_Providers/auth.dart';
import '../models/user.dart';

class UserRepository {
  final AuthProvider authProvider = new AuthProvider();
  Future<void> SignUp({User? user}) async {
    try {
      await authProvider.signup(user!);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> Login(
      {String? username, String? password}) async {
    try {
      return await authProvider.login(username!, password!);
    } catch (e) {
      rethrow;
    }
  }
}
