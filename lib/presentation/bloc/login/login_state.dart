part of 'login_bloc.dart';

abstract class LoginState extends Equatable {

  final LoginParams serverParams;
   String userEnteredPin;

    LoginState({required this.serverParams,required this.userEnteredPin});
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
   LoginInitial()
      : super(serverParams: const LoginParams(phoneNum: '',pinCode: ''),userEnteredPin: '');
}



/// The received pinCode is saved
class ReceivedPinCodeSaved extends LoginState {

    ReceivedPinCodeSaved({required LoginParams serverParams,required String userEnteredPin})
       : super(serverParams: serverParams,userEnteredPin: userEnteredPin);

}



/// Wrong code entered
class WrongCodeEntered extends LoginState {
  final AppError appError;

   WrongCodeEntered( {required this.appError,required LoginParams serverParams,required String userEnteredPin})
      : super(serverParams: serverParams,userEnteredPin: userEnteredPin);

   @override
  List<Object> get props => [userEnteredPin,appError.message];
}


/// Correct code entered
class CorrectCodeEntered extends LoginState {

   CorrectCodeEntered()
      : super(serverParams: const LoginParams(phoneNum: '',pinCode: ''),userEnteredPin: '');
}

