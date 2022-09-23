import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_login_view_state.dart';

class ChangeLoginViewCubit extends Cubit<LoginView> {

  ChangeLoginViewCubit() : super( LoginView.phoneNum);


  void _emitIfNotClosed(LoginView state){
    if(!isClosed){
      emit(state);
    }
  }

  void changeToPhoneNum()=>_emitIfNotClosed(LoginView.phoneNum);
  void changeToPinCodeView()=>_emitIfNotClosed(LoginView.pinCode);

}
