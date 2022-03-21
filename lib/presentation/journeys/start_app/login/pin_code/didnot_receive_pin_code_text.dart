import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:remax_mapstate/presentation/cubit/count_down_cubit/count_down_cubit.dart';

import '../../../../bloc/login/login_bloc.dart';
import '../../../../themes/theme_color.dart';

class NotReceiveCodeText extends StatelessWidget {
  final Function() onResendPressed;

  const NotReceiveCodeText({Key? key, required this.onResendPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountDownCubit, CountDownState>(
      builder: (context, state) {
        /// Start countDown
        if (state is CountDownStarted) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CountdownTimer(
                controller: state.timerController,
                // endTime: _getWaitingTime(),
                widgetBuilder: (_, time) {
                  if (time == null) {
                    return const SizedBox.shrink();
                  }
                  return RichText(
                    text: TextSpan(
                      text: TranslateConstants.tryAgainAfter.t(context),
                      children: [
                        TextSpan(
                          text: "${time.sec}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: AppColor.fadeGeeBung,fontWeight: FontWeight.bold),
                        ),
                      ],
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: AppColor.geeBung,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ],
          );
        }

        /// End countDown
        if (state is CountDownEnded) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                TranslateConstants.didNotReceiveCode.t(context),
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: AppColor.geeBung,
                ),
              ),
              TextButton(
                  onPressed: () =>
                      context.read<LoginBloc>().add(ResendPinCode()),
                  child: Text(
                    TranslateConstants.tryAgain.t(context),
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: AppColor.fadeGeeBung, fontWeight: FontWeight.bold),
                  ))
            ],
          );
        }

        /// Default view
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TranslateConstants.didNotReceiveCode.t(context),
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: AppColor.geeBung,
              ),
            ),
            TextButton(
                onPressed: () => context.read<LoginBloc>().add(ResendPinCode()),
                child: Text(
                  TranslateConstants.resend.t(context).toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: AppColor.fadeGeeBung, fontWeight: FontWeight.bold),
                ))
          ],
        );
      },
    );
  }
}
