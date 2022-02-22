import 'package:equatable/equatable.dart';

class LoginParams extends Equatable{

  final String phoneNum;
  final String pinCode;

  const LoginParams({
    required this.phoneNum,
    this.pinCode = '',
  });

  @override
  List<Object?> get props => [phoneNum];
}