import 'package:formz/formz.dart';

enum ConfirmedPasswordError {
  invalid,
  mismatch,
}

class ConfirmedPassword extends FormzInput<String, ConfirmedPasswordError> {
  final String password;

  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');

  const ConfirmedPassword.dirty({required value, required this.password})
      : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == ConfirmedPasswordError.invalid) {
      return 'Confirm Password is empty';
    }
    if (displayError == ConfirmedPasswordError.mismatch) {
      return 'Passwords is not match';
    }

    return null;
  }

  @override
  ConfirmedPasswordError? validator(String value) {
    if (value.isEmpty) {
      return ConfirmedPasswordError.invalid;
    }
    if (password != value) {
      return ConfirmedPasswordError.mismatch;
    }

    return null;
  }
}

// enum ConfirmedPasswordValidationError {
//   invalid,
//   mismatch,
// }

// class ConfirmedPassword extends FormzInput<String, ConfirmedPasswordValidationError> {
//   final String password;

//   const ConfirmedPassword.pure({
//     this.password = ''
//   }) : super.pure('');

//   const ConfirmedPassword.dirty({
//     required this.password,
//     String value = ''
//   }) : super.dirty(value);

//   @override
//   ConfirmedPasswordValidationError? validator(String value) {
//     if (value.isEmpty) {
//       return ConfirmedPasswordValidationError.invalid;
//     }
//     return password == value
//         ? null
//         : ConfirmedPasswordValidationError.mismatch;
//   }
// }

// extension Explanation on ConfirmedPasswordValidationError {
//   String? get name {
//     switch(this) {
//       case ConfirmedPasswordValidationError.mismatch:
//         return 'passwords must match';
//       default:
//         return null;
//     }
//   }
// }