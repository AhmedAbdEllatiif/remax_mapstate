import 'package:formz/formz.dart';

enum NumberOfYearsError { invalid,requiredField  }

class NumberOfYears extends FormzInput<String, NumberOfYearsError> {

  // Call super.pure to represent an unmodified form input.
  const NumberOfYears.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const NumberOfYears.dirty({required String value}) : super.dirty(value);


  /// must follow (2) or (2.5) with only five
  static final _numOfYearsRegex = RegExp(
    r'^0*[1-9][0-9]*(\.[5])*$',
  );


  @override
  NumberOfYearsError? validator(String value) {
    if(value.isEmpty) return NumberOfYearsError.requiredField;
    return _numOfYearsRegex.hasMatch(value) ? null : NumberOfYearsError.invalid;
  }
}
