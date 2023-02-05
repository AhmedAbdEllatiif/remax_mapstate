import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/functions/get_authorized_user.dart';
import 'package:remax_mapstate/common/functions/get_user_token.dart';
import 'package:remax_mapstate/common/functions/show_dialog.dart';

import 'package:remax_mapstate/common/functions/show_snack_bar.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:remax_mapstate/presentation/logic/cubit/request_a_call/request_call_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/constants/translate_constatns.dart';
import '../../../router/route_hepler.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_button.dart';
import '../choose_broker/arguments/choose_broker_argument.dart';

class ButtonSection extends StatefulWidget {
  final Function() onPressed;
  final Function() onChooseBrokerPressed;
  final String projectId;

  const ButtonSection({
    Key? key,
    required this.onPressed,
    required this.projectId,
    required this.onChooseBrokerPressed,
  }) : super(key: key);

  @override
  State<ButtonSection> createState() => _ButtonSectionState();
}

class _ButtonSectionState extends State<ButtonSection> {
  late final RequestCallCubit _requestCallCubit;

  @override
  void initState() {
    super.initState();
    _requestCallCubit = getItInstance<RequestCallCubit>();
  }

  @override
  void dispose() {
    _requestCallCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _requestCallCubit,
      child: BlocListener<RequestCallCubit, RequestCallState>(
        listener: (context, state) {
          if (state is RequestCallSuccessfullySent) {
            _showCallRequestedSuccessfully();
          }

          if (state is AlreadyRequestOnThisProject) {
            _showCallAlreadyRequested();
          }

          if (state is ErrorWhileRequestingCall) {
            showSnackBar(
              context,
              textColor: AppColor.black,
              message: TranslateConstants.somethingWentWrong.t(context),
            );
          }
        },
        child: BlocBuilder<AuthorizedUserCubit, AuthorizedUserState>(
          builder: (context, state) {
            final userType = state.currentUserType;

            ///  tour or noUser
            if (userType == UserType.tour || userType == UserType.unDefined) {
              return Container(
                color: AppColor.white.withOpacity(0.2),
                padding: EdgeInsets.symmetric(
                  vertical: Sizes.dimen_5.h,
                  horizontal: Sizes.dimen_16.w,
                ),
                child: AppButtonGradient(
                  text: TranslateConstants.login.t(context).toUpperCase(),
                  onPressed: () {
                    RouteHelper()
                        .chooseUserTypeScreen(context, isClearStack: true);
                  },
                ),
              );
            }

            /// client
            if (userType == UserType.client) {
              return Container(
                color: AppColor.white.withOpacity(0.2),
                padding: EdgeInsets.symmetric(vertical: Sizes.dimen_5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /// requestACall button
                    BlocBuilder<RequestCallCubit, RequestCallState>(
                      builder: (context, state) {
                        if (state is LoadingRequestCall) {
                          return const Center(
                            child: LoadingWidget(),
                          );
                        }
                        return AppButtonGradient(
                          text: TranslateConstants.requestACall
                              .t(context)
                              .toUpperCase(),
                          onPressed: () => _tryToRequestCall(),
                        );
                      },
                    ),

                    /// selectYourBroker
                    AppButtonGradient(
                      text: TranslateConstants.selectYourBroker
                          .t(context)
                          .toUpperCase(),
                      reverseGradient: true,
                      onPressed: widget.onChooseBrokerPressed,
                    ),
                  ],
                ),
              );
            }

            /// broker or ambassador
            if (userType == UserType.broker ||
                userType == UserType.ambassador) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Sizes.dimen_16.w),
                    topLeft: Radius.circular(Sizes.dimen_16.w),
                  ),
                ),
                // padding: EdgeInsets.symmetric(
                //   vertical: Sizes.dimen_5.h,
                //   horizontal: Sizes.dimen_16.w,
                // ),
                child: AppButtonGradient(
                  textColor: AppColor.black,
                  text: TranslateConstants.contactWithDeveloper.t(context),
                  onPressed: widget.onPressed,
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  /// to send request call
  void _tryToRequestCall() {
    final userToken = getUserToken(context);
    final userId = getAuthorizedUser(context).id;
    final projectId = widget.projectId;

    _requestCallCubit.tryRequestCall(
      userToken: userToken,
      userId: userId,
      projectId: projectId,
    );
  }

  /// to show success dialog
  void _showCallRequestedSuccessfully() {
    showSuccessDialog(context,
        message: TranslateConstants.callRequested.t(context));
  }

  /// to show already requested dialog
  void _showCallAlreadyRequested() {
    showSuccessDialog(context,
        message: TranslateConstants.alreadyRequestOnThisProject.t(context));
  }
}
