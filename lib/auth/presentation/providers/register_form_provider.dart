import 'package:ecommerce_ui_flutter/shared/infrastructure/inputs/confirm_password.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import 'package:ecommerce_ui_flutter/shared/shared.dart';
import 'package:ecommerce_ui_flutter/auth/presentation/providers/auth_provider.dart';

final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;

  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String) registerUserCallback;

  RegisterFormNotifier({
    required this.registerUserCallback,
  }) : super(RegisterFormState());

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate(
        [newEmail, state.password, state.confirm],
      ),
    );
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate(
        [newPassword, state.email, state.confirm],
      ),
    );
  }

  onConfirmPasswordChanged(String value) {
    final newConfirm = ConfirmedPassword.dirty(
      value: state.confirm.value,
      password: state.password.value,
    );

    state = state.copyWith(
      confirm: newConfirm,
      isValid: Formz.validate(
        [newConfirm, state.email, state.password],
      ),
    );
  }

  onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;
    state = state.copyWith(isPosting: true);

    await registerUserCallback(
        state.email.value, state.password.value, state.confirm.value);

    state = state.copyWith(isPosting: false);
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirm = ConfirmedPassword.dirty(
      value: state.confirm.value,
      password: state.password.value,
    );

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      confirm: confirm,
      isValid: Formz.validate(
        [email, password, confirm],
      ),
    );
  }
}

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final ConfirmedPassword confirm;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirm = const ConfirmedPassword.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    ConfirmedPassword? confirm,
  }) =>
      RegisterFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
        confirm: confirm ?? this.confirm,
      );

  @override
  String toString() {
    return '''
      RegisterFormState:
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      email: $email
      password: $password
      confirm: $confirm
    ''';
  }
}
