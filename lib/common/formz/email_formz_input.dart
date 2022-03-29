import 'package:formz/formz.dart';

enum EmailValidationError { invalid }


class EmailFormzInput extends FormzInput<String, EmailValidationError> {

  // Call super.pure to represent an unmodified form input.
  const EmailFormzInput.pure() :super.pure('');

  // Call super.dirty to represent a modified form input.
  const EmailFormzInput.dirty({String value = ''}) :super.dirty(value);

  //expression to validate email
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  // Override validator to handle validating a given input value.
  @override
  EmailValidationError? validator(String value) {
    return _emailRegex.hasMatch(value) ? null : EmailValidationError.invalid;
    //return value.isNotEmpty == true ? null: EmailValidationError.invalid;
  }

}