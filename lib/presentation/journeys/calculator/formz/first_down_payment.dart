import 'package:formz/formz.dart';

enum FirstDownPaymentError { invalid,requiredField }

class FirstDownPaymentForm extends FormzInput<String, FirstDownPaymentError> {

  // Call super.pure to represent an unmodified form input.
  const FirstDownPaymentForm.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const FirstDownPaymentForm.dirty({required String value}) : super.dirty(value);


  /// must follow (2) or (2.5) with only five
  static final _firstDownPaymentRegex = RegExp(
    r'^0*[1-9][0-9]*(\.[0-9]+)*$',
  );


  @override
  FirstDownPaymentError? validator(String value) {
    if(value.isEmpty) return FirstDownPaymentError.requiredField;
    return _firstDownPaymentRegex.hasMatch(value) ? null : FirstDownPaymentError.invalid;
  }
}
