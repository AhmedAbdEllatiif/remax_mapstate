import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/team_support_entity.dart';
import 'package:remax_mapstate/presentation/journeys/developer_contact/developer_contact_image.dart';
import 'package:remax_mapstate/presentation/journeys/team_support/team_support_info_card.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/functions/get_user_token.dart';
import '../../../common/screen_utils/screen_util.dart';
import '../../logic/cubit/team_support/team_support_cubit.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/city_background_widget.dart';

class TeamSupportScreen extends StatefulWidget {
  const TeamSupportScreen({Key? key}) : super(key: key);

  @override
  _TeamSupportScreen createState() => _TeamSupportScreen();
}

class _TeamSupportScreen extends State<TeamSupportScreen> {
  late final TeamSupportCubit _teamSupportCubit;

  @override
  void initState() {
    super.initState();
    _teamSupportCubit = getItInstance<TeamSupportCubit>();
    _fetchTeamSupportData();
  }

  @override
  void dispose() {
    _teamSupportCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _teamSupportCubit,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil.screenWidth * 0.1,
          vertical: Sizes.dimen_4.h,
        ),
        child: BlocBuilder<TeamSupportCubit, TeamSupportState>(
          builder: (context, state) {
            /*
            *
            *
            * loading
            *
            *
            * */
            if (state is LoadingTeamSupportState) {
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

            if (state is NoTeamSupportFound) {
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

            if (state is ErrorWhileLoadingTeamSupport) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: state.appError.appErrorType,
                  onPressedRetry: () {
                    _fetchTeamSupportData();
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
            if (state is TeamSupportDataLoaded) {
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
                      imageUrl: state.teamSupportEntity.avatar,
                      assetImage: false,
                    ),
                  ),

                  /// contact data card
                  TeamSupportCardInfo(
                      teamSupportEntity: state.teamSupportEntity)
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

  void _fetchTeamSupportData() {
    final userToken = getUserToken(context);
    _teamSupportCubit.loadTeamSupportData(userToken: userToken);
  }
}
