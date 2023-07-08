import 'package:formz/formz.dart';

enum FourthDownPaymentError { invalid, requiredField }

class FourthDownPaymentForm extends FormzInput<String, FourthDownPaymentError> {
  // Call super.pure to represent an unmodified form input.
  const FourthDownPaymentForm.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const FourthDownPaymentForm.dirty({required String value})
      : super.dirty(value);

  /// must follow (2) or (2.5) with only five
  static final _fourthDownPaymentRegx = RegExp(
    r'^0*[1-9][0-9]*(\.[0-9]+)*$',
  );

  @override
  FourthDownPaymentError? validator(String value) {
    //if (value.isEmpty) return FourthDownPaymentError.requiredField;
    if(value.isEmpty) return null;
    if(_fourthDownPaymentRegx.hasMatch(value)) {
      final num = int.parse(value);
      if(num >= 100){
        return FourthDownPaymentError.invalid;
      }
    }
    return _fourthDownPaymentRegx.hasMatch(value)
        ? null
        : FourthDownPaymentError.invalid;
  }
}
