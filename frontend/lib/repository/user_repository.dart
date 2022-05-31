import 'package:dio/dio.dart';
import '../data_Providers/auth.dart';
import '../models/user.dart';

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
