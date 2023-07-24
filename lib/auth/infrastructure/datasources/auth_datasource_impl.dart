import 'package:dio/dio.dart';

import 'package:ecommerce_ui_flutter/auth/domain/datasources/auth_datasource.dart';
import 'package:ecommerce_ui_flutter/auth/domain/entities/user.dart';
import 'package:ecommerce_ui_flutter/auth/infrastructure/errors/auth_errors.dart';
import 'package:ecommerce_ui_flutter/auth/infrastructure/mappers/user_mapper.dart';
import 'package:ecommerce_ui_flutter/config/constants/enviroments.dart';

class AuthDatasourceImpl extends AuthDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    ),
  );

  @override
  Future<User> checkAuthStatus(String token) {
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final res = await dio.post(
        '/users/login',
        data: {"email": email, "password": password},
      );

      res.data['user']['token'] = res.data['token'];

      final user = UserMapper.userJsonToEntity(res.data['user']);

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        throw CustomError(e.response?.data["message"]);
      } else {
        throw WrongCredentials();
      }
    } catch (e) {
      throw WrongCredentials();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    throw UnimplementedError();
  }
}
