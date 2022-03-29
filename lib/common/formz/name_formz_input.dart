import 'package:formz/formz.dart';

enum NameValidationError { invalid }


class NameFormzInput extends FormzInput<String, NameValidationError> {

  // Call super.pure to represent an unmodified form input.
  const NameFormzInput.pure() :super.pure('');

  // Call super.dirty to represent a modified form input.
  const NameFormzInput.dirty({String value = ''}) :super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  NameValidationError? validator(String value) {
    return value.isNotEmpty ? null : NameValidationError.invalid;
    //return value.isNotEmpty == true ? null: EmailValidationError.invalid;
  }

}