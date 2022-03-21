import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

import '../../../../bloc/login/login_bloc.dart';

class EnterCodeWithPhoneNumberText extends StatelessWidget {
  const EnterCodeWithPhoneNumberText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.dimen_32.w, vertical: Sizes.dimen_6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                TranslateConstants.enterTheCode.t(context) + "  ",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColor.geeBung),
                textAlign: TextAlign.center,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  state.serverParams.phoneNum,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: AppColor.fadeGeeBung,fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
