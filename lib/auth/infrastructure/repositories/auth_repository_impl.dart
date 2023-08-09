import 'package:ecommerce_ui_flutter/auth/domain/entities/user.dart';
import 'package:ecommerce_ui_flutter/auth/domain/datasources/auth_datasource.dart';
import 'package:ecommerce_ui_flutter/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<User> uploadProfile(String token, Map<String, dynamic> obj) {
    return dataSource.uploadProfile(token, obj);
  }

  @override
  Future<User> register(String email, String password, String fullName,
      {bool service = false}) {
    return dataSource.register(email, password, fullName, service: service);
  }
}
