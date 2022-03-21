import 'package:formz/formz.dart';

enum SecondDownPaymentError { invalid,requiredField }

class SecondDownPaymentForm extends FormzInput<String, SecondDownPaymentError> {

  // Call super.pure to represent an unmodified form input.
  const SecondDownPaymentForm.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const SecondDownPaymentForm.dirty({required String value}) : super.dirty(value);


  /// must follow (2) or (2.5) with only five
  static final _secondDownPaymentRegx = RegExp(
    r'^0*[1-9][0-9]*(\.[0-9]+)*$',
  );


  @override
  SecondDownPaymentError? validator(String value) {
    if(value.isEmpty) return SecondDownPaymentError.requiredField;
    return _secondDownPaymentRegx.hasMatch(value) ? null : SecondDownPaymentError.invalid;
  }
}
