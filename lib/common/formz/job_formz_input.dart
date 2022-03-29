import 'package:formz/formz.dart';

enum JobValidationError { invalid }


class JobFormzInput extends FormzInput<String, JobValidationError> {

  // Call super.pure to represent an unmodified form input.
  const JobFormzInput.pure() :super.pure('');

  // Call super.dirty to represent a modified form input.
  const JobFormzInput.dirty({String value = ''}) :super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  JobValidationError? validator(String value) {
    return value.isNotEmpty ? null : JobValidationError.invalid;
    //return value.isNotEmpty == true ? null: EmailValidationError.invalid;
  }

}