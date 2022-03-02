import 'package:formz/formz.dart';

enum UnitPriceError { invalid,requiredField }

class UnitPrice extends FormzInput<String, UnitPriceError> {

  // Call super.pure to represent an unmodified form input.
  const UnitPrice.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const UnitPrice.dirty({required String value}) : super.dirty(value);



  static final _numRegex = RegExp(
    r'^0*[1-9][0-9]*(\.[0-9]+)*$',
  );


  @override
  UnitPriceError? validator(String value) {
    if(value == '') return UnitPriceError.requiredField;
    return _numRegex.hasMatch(value) ? null : UnitPriceError.invalid;
  }

}
