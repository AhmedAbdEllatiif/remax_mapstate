import 'package:formz/formz.dart';

enum PasswordValidationError { invalidRegex, emptyPassword }

class PasswordValidation extends FormzInput<String, PasswordValidationError> {
  // Call super.pure to represent an unmodified form input.
  const PasswordValidation.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PasswordValidation.dirty({String value = ''}) : super.dirty(value);

  static final _passwordRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.emptyPassword;
    if (!_passwordRegex.hasMatch(value)) return PasswordValidationError.invalidRegex;
    return null;
  }
}
