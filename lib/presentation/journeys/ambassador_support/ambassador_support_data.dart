import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/constants/translate_constatns.dart';
import '../../../common/functions/get_user_token.dart';
import '../../../common/screen_utils/screen_util.dart';
import '../../../di/git_it.dart';
import '../../logic/cubit/ambassador_support/ambassador_support_cubit.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../developer_contact/developer_contact_image.dart';
import '../team_support/team_support_info_card.dart';
import 'ambassador_support_card_info.dart';

class AmbassadorSupportDataWidget extends StatefulWidget {
  const AmbassadorSupportDataWidget({Key? key}) : super(key: key);

  @override
  _AmbassadorSupportDataWidget createState() => _AmbassadorSupportDataWidget();
}

class _AmbassadorSupportDataWidget extends State<AmbassadorSupportDataWidget> {
  late final AmbassadorSupportCubit _ambassadorSupportCubit;

  @override
  void initState() {
    super.initState();
    _ambassadorSupportCubit = getItInstance<AmbassadorSupportCubit>();
    _fetchAmbassadorSupportData();
  }

  @override
  void dispose() {
    _ambassadorSupportCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _ambassadorSupportCubit,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil.screenWidth * 0.1,
          vertical: Sizes.dimen_4.h,
        ),
        child: BlocBuilder<AmbassadorSupportCubit, AmbassadorSupportState>(
          builder: (context, state) {
            /*
            *
            *
            * loading
            *
            *
            * */
            if (state is LoadingAmbassadorSupportState) {
              return const Center(
                child: LoadingWidget(),
              );
            }

            /*
            *
            *
            * no team support
            *
            *
            * */

            if (state is NoAmbassadorSupportFound) {
              return Center(
                  child:
                      Text(TranslateConstants.noTeamSupportFound.t(context)));
            }

            /*
            *
            *
            * error
            *
            *
            * */

            if (state is ErrorWhileLoadingAmbassadorSupport) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: state.appError.appErrorType,
                  onPressedRetry: () {
                    _fetchAmbassadorSupportData();
                  },
                ),
              );
            }

            /*
            *
            *
            * success
            *
            *
            * */
            if (state is AmbassadorSupportDataLoaded) {
              log("Avatar ${state.ambassadorSupportEntity.avatar}");
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// image
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: ScreenUtil.screenHeight * 0.40,
                      maxWidth: ScreenUtil.screenWidth * 0.7,
                      minHeight: ScreenUtil.screenHeight * 0.35,
                      minWidth: ScreenUtil.screenWidth * 0.7,
                    ),
                    margin: EdgeInsets.only(bottom: Sizes.dimen_10.h),
                    child: ContactImage(
                      imageUrl: state.ambassadorSupportEntity.avatar,
                      assetImage: false,
                    ),
                  ),

                  /// contact data card
                  AmbassadorSupportCardInfo(
                    ambassadorSupportEntity: state.ambassadorSupportEntity,
                  )
                ],
              );
            }

            /// else
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _fetchAmbassadorSupportData() {
    final userToken = getUserToken(context);
    _ambassadorSupportCubit.loadAmbassadorSupportData(userToken: userToken);
  }
}
