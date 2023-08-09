import 'package:ecommerce_ui_flutter/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String fullName,
      {bool service = false});
  Future<User> checkAuthStatus(String token);
  Future<User> uploadProfile(String token, Map<String, dynamic> obj);
}
