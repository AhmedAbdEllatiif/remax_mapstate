import 'package:formz/formz.dart';

enum DownPaymentError { invalid,requiredField }

class DownPaymentForm extends FormzInput<String, DownPaymentError> {

  // Call super.pure to represent an unmodified form input.
  const DownPaymentForm.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const DownPaymentForm.dirty({required String value}) : super.dirty(value);


  /// must follow (2) or (2.5) with only five
  static final _downPaymentRegex = RegExp(
    r'^0*[1-9][0-9]*(\.[0-9]+)*$',
  );


  @override
  DownPaymentError? validator(String value) {
    if(value.isEmpty) return DownPaymentError.requiredField;
    return _downPaymentRegex.hasMatch(value) ? null : DownPaymentError.invalid;
  }
}
