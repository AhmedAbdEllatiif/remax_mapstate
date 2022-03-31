import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/presentation/bloc/login/login_bloc.dart';
import 'package:remax_mapstate/presentation/cubit/auto_login/auto_login_cubit.dart';
import 'package:remax_mapstate/presentation/cubit/current_user/current_user_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/btn_with_box_shadow.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/login/pin_code/didnot_receive_pin_code_text.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/login/pin_code/enter_code_with_phone_number_text.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/login/pin_code/pin_code_form.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/login/pin_code/pin_error_text.dart';

import '../../../../../common/constants/translate_constatns.dart';
import '../../../../../common/enums/user_types.dart';
import '../../../../../router/route_hepler.dart';
import 'enter_otp_animation.dart';

class OtpVerificationCode extends StatefulWidget {
  const OtpVerificationCode({
    Key? key,
  }) : super(key: key);

  @override
  State<OtpVerificationCode> createState() => _OtpVerificationCodeState();
}

class _OtpVerificationCodeState extends State<OtpVerificationCode> {
  TextEditingController textEditingController = TextEditingController();


  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// To add new event to loginBloc
  _addBloc(BuildContext context, LoginEvent event) =>
      BlocProvider.of<LoginBloc>(context).add(event);

  /// navigate to NextScreen
  void _navigateToNextScreen(BuildContext context) async{

    final currentUser = await context.read<CurrentUserCubit>().getCurrentUserType();
    switch(currentUser){

      case UserType.client:
        RouteHelper().clientRegistrationScreen(context);
        break;
      case UserType.broker:
        RouteHelper().brokerRegistrationScreen(context);
        break;
      case UserType.ambassador:
        RouteHelper().spotterRegistrationScreen(context);
        break;
      case UserType.tour:
      case UserType.noUser:
        throw UnimplementedError("_navigateToNextScreen No User");
    }


  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is CorrectCodeEntered) {

          /// navigate to login screen
          _navigateToNextScreen(context);
        }
      },
      child: ListView(
        shrinkWrap: true,
        children: [
          /// Lottie animation
          SizedBox(
            width: ScreenUtil.screenWidth,
            height: ScreenUtil.screenHeight * 0.32,
            child: const EnterOtpAnimation(),
          ),

          /// separator
          const SizedBox(height: 8),

          /// Enter the code sent to 0100********
          const EnterCodeWithPhoneNumberText(),

          /// separator
          const SizedBox(height: 20),

          /// Form
          PinCodeForm(
            textEditingController: textEditingController,
            errorController: errorController,
            formKey: formKey,
          ),

          /// pin Error Text
          const PinErrorText(),

          /// separator
          const SizedBox(height: 20),

          /// Didn't receive the code
          NotReceiveCodeText(onResendPressed: () {}),

          /// separator
          const SizedBox(height: 14),

          /// btn VERIFY
          ButtonWithBoxShadow(
              text: TranslateConstants.verify.t(context).toUpperCase(),
              onPressed: () {
                _addBloc(context, const VerifyPinCodeEvent());
                errorController!.add(ErrorAnimationType.shake);
              }),
        ],
      ),
    );
  }
}
