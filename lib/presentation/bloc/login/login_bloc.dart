import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/login_params.dart';

import '../../cubit/count_down_cubit/count_down_cubit.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final CountDownCubit countDownCubit;

  LoginBloc({required this.countDownCubit}) : super(LoginInitial()) {
    /*void clearAllAndStartRequesting() => emit(LoginInitial());

    void requestVerificationCodeEvent(String phoneNum){

      const pinCode = "123456";
      emit(EnterReceivedPinCode(loginParams: LoginParams(phoneNum: phoneNum,pinCode: pinCode)));
    }
    */
    on<LoginEvent>((event, emit) async {

      void _emitIfNotClosed(LoginState state){
        if(!isClosed){
          emit(state);
        }
      }

      /// Request new pin code event
      if (event is RequestPinCodeEvent) {
        final phoneNum = event.loginParams.phoneNum;
        // TODO get this pinCode from the server
        const serverPinCode = "123456";

        /// start the countDown
        countDownCubit.endCountDown();

        /// emit the pinCode is received
        _emitIfNotClosed(ReceivedPinCodeSaved(
            serverParams:
                LoginParams(phoneNum: phoneNum, pinCode: serverPinCode),
            userEnteredPin: state.userEnteredPin));
        // emit(WaitingForVerificationCode());
        /* Future.delayed(const Duration(milliseconds: 3000),() async {
        }).whenComplete(() {

        });*/
      }

      /// Resend pin
      if (event is ResendPinCode) {
        /// start the countDown
        countDownCubit.startCountDown();

        /*emit(
          StartWaitingForVerificationCode(
            serverParams: LoginParams(
                phoneNum: state.serverParams.phoneNum,
                pinCode: state.serverParams.pinCode),
            userEnteredPin: state.userEnteredPin,
          ),
        );*/

        /* await Future.delayed(const Duration(milliseconds: 50000),() async {
        }).whenComplete(() {
          emit(ReceivedPinCodeSaved(
              serverParams: LoginParams(phoneNum: state.serverParams.phoneNum, pinCode: state.serverParams.pinCode),userEnteredPin: state.userEnteredPin));
        });*/
      }


      /// OnPinChanged
      /// To add changes on pin entered by user
      if (event is OnPinChanged) {
        state.userEnteredPin = event.changedPin;
        print("LoginBloc >> OnPinChanged ${state.userEnteredPin}");
      }

      /// VerifyPinCodeEvent
      if (event is VerifyPinCodeEvent) {
        final params = state.serverParams;
        final serverPinCode = params.pinCode;
        final userEnteredPin = state.userEnteredPin;
        if (serverPinCode.isNotEmpty && serverPinCode == userEnteredPin) {
          _emitIfNotClosed(CorrectCodeEntered());
        } else {
          if (userEnteredPin.isEmpty) {
            _emitIfNotClosed(WrongCodeEntered(
                appError: const AppError(AppErrorType.validation,
                    message: TranslateConstants.pinCodeRequired),
                serverParams: state.serverParams,
                userEnteredPin: state.userEnteredPin));
          } else if (userEnteredPin.length < 6) {
            _emitIfNotClosed(WrongCodeEntered(
                appError: const AppError(AppErrorType.validation,
                    message: TranslateConstants.pinCodeAtLeast6),
                serverParams: state.serverParams,
                userEnteredPin: state.userEnteredPin));
          } else if (serverPinCode != userEnteredPin) {
            _emitIfNotClosed(WrongCodeEntered(
                appError: const AppError(AppErrorType.validation,
                    message: TranslateConstants.wrongPinCode),
                serverParams: state.serverParams,
                userEnteredPin: state.userEnteredPin));
          }
        }
      }
    });
  }
}
