import 'package:ecommerce_ui_flutter/auth/domain/auth_repository.dart';
import 'package:ecommerce_ui_flutter/auth/domain/entities/user.dart';
import 'package:ecommerce_ui_flutter/auth/infrastructure/datasources/auth_datasource_impl.dart';
import 'package:ecommerce_ui_flutter/auth/infrastructure/errors/auth_errors.dart';
import 'package:ecommerce_ui_flutter/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl(AuthDatasourceImpl());
  // final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    // keyValueStorageService: keyValueStorageService
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  // final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    // required this.keyValueStorageService,
  }) : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error 404');
    }
  }

  void registerUser(String email, String password) async {}

  void checkAuthStatus() async {
    // final token = await keyValueStorageService.getValue<String>('token');
    // if (token == null) return logout();

    // try {
    //   final user = await authRepository.checkAuthStatus(token);
    //   _setLoggedUser(user);
    // } catch (e) {
    //   logout();
    // }
  }

  void _setLoggedUser(User user) async {
    // await keyValueStorageService.setKeyValue('token', user.token);

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([String? errorMessage]) async {
    // await keyValueStorageService.removeKey('token');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}