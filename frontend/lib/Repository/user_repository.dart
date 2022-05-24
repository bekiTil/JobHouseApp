import 'package:dio/dio.dart';
import '../Data_Provider/auth.dart';
import '../Models/user.dart';

class UserRepository {
  final AuthProvider authProvider = new AuthProvider();
  Future<void> SignUp({User? user}) async {
    await authProvider.signup(user!);
  }

  Future<Map<String, dynamic>> Login(
      {String? username, String? password}) async {
    return await authProvider.login(username!, password!);
  }
}
