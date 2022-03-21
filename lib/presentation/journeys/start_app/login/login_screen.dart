import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/bloc/login/login_bloc.dart';
import 'package:remax_mapstate/presentation/cubit/change_login_view/change_login_view_cubit.dart';
import 'package:remax_mapstate/presentation/cubit/count_down_cubit/count_down_cubit.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/login/phone_num.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/login/pin_code/otp_verification.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginBloc loginBloc;
  late final CountDownCubit countDownCubit;
  late final ChangeLoginViewCubit changeLoginViewCubit;

  @override
  void initState() {
    super.initState();
    loginBloc = getItInstance<LoginBloc>();
    countDownCubit = loginBloc.countDownCubit;
    changeLoginViewCubit = getItInstance<ChangeLoginViewCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    loginBloc.close();
    countDownCubit.close();
    changeLoginViewCubit.close();
  }

  /// Handle onBackPressed
  Future<bool> _willPopScopeCall(BuildContext context) async {
    if(changeLoginViewCubit.state == LoginView.pinCode){
      changeLoginViewCubit.changeToPhoneNum();
      return false;
    }
// code to show toast or modal
    return true; // return true to exit app or return false to cancel exit
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
     providers: [
       BlocProvider.value(value: loginBloc),
       BlocProvider.value(value: changeLoginViewCubit),
       BlocProvider.value(value: countDownCubit),
     ],
      child: WillPopScope(
        onWillPop:()=> _willPopScopeCall(context),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              TranslateConstants.login.t(context),
            ),
          ),
          body: BlocBuilder<ChangeLoginViewCubit, LoginView>(
            builder: (context, state) {

              /// PhoneNumWidget
              if(state == LoginView.phoneNum){
                return const AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: PhoneNumWidget(),
                );
              }

              /// OtpVerificationCode
              return const AnimatedSwitcher(
                duration:  Duration(milliseconds: 500),
                child: OtpVerificationCode(
                ),
              );

            },
          ),

        ),
      ),
    );
  }
}
