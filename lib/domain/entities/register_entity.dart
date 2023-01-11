import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable{
  final String userToken;

  const RegisterEntity({
    required this.userToken,
  });

  @override

  List<Object?> get props => [userToken];
}
