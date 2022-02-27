import 'package:equatable/equatable.dart';

class PhoneNumParams extends Equatable{

  final String phoneNum;

  const PhoneNumParams({
    required this.phoneNum,
  });

  @override
  List<Object?> get props => [phoneNum];

}
