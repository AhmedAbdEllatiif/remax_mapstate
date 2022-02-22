import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

import '../../../../bloc/login/login_bloc.dart';

class EnterCodeWithPhoneNumberText extends StatelessWidget {
  const EnterCodeWithPhoneNumberText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding:
           EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w, vertical: Sizes.dimen_6.h),
          child: RichText(
            text: TextSpan(
                text: TranslateConstants.enterTheCode.t(context),
                children: [
                  TextSpan(
                    text: state.serverParams.phoneNum,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
                style: Theme.of(context).textTheme.subtitle1,),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
