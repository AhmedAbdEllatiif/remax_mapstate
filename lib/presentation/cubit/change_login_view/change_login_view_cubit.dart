import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_login_view_state.dart';

class ChangeLoginViewCubit extends Cubit<LoginView> {

  ChangeLoginViewCubit() : super( LoginView.phoneNum);


  void changeToPhoneNum()=>emit(LoginView.phoneNum);
  void changeToPinCodeView()=>emit(LoginView.pinCode);

}
