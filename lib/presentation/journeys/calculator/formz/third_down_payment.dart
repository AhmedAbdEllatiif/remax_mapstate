import 'package:formz/formz.dart';

enum ThirdDownPaymentError { invalid,requiredField }

class ThirdDownPaymentForm extends FormzInput<String, ThirdDownPaymentError> {

  // Call super.pure to represent an unmodified form input.
  const ThirdDownPaymentForm.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const ThirdDownPaymentForm.dirty({required String value}) : super.dirty(value);


  /// must follow (2) or (2.5) with only five
  static final _thirdDownPaymentRegx = RegExp(
    r'^0*[1-9][0-9]*(\.[0-9]+)*$',
  );


  @override
  ThirdDownPaymentError? validator(String value) {
    if(value.isEmpty) return ThirdDownPaymentError.requiredField;
    return _thirdDownPaymentRegx.hasMatch(value) ? null : ThirdDownPaymentError.invalid;
  }
}
