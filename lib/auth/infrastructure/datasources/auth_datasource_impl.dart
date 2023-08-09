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
  Future<User> checkAuthStatus(String token) async {
    try {
      final res = await dio.get('/users/profile',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      res.data['user']['message'] = res.data['message'];
      res.data['user']['token'] = token;

      final user = UserMapper.userJsonToEntity(res.data['user']);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        throw CustomError(e.response?.data["message"]);
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final res = await dio.post(
        '/users/login',
        data: {"email": email, "password": password},
      );

      res.data['user']['token'] = res.data['token'];
      res.data['user']['message'] = res.data['message'];
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
  Future<User> register(String email, String password, String fullName,
      {bool service = false}) async {
    try {
      final res = await dio.post(
        '/users/register',
        data: {
          "email": email,
          "password": password,
          "fullname": fullName,
          "service": service
        },
      );

      if (service) {
        res.data['user']['token'] = res.data['token'];
        res.data['user']['message'] = res.data['message'];
      }

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
  Future<User> uploadProfile(String token, Map<String, dynamic> obj) async {
    final res = await dio.put('/users/update/shipping',
        data: obj,
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    res.data['user']['token'] = token;
    res.data['user']['message'] = res.data['message'];
    final user = UserMapper.userJsonToEntity(res.data['user']);

    return user;
  }
}
