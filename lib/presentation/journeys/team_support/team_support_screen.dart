import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/journeys/developer_contact/developer_contact_image.dart';
import 'package:remax_mapstate/presentation/journeys/team_support/team_support_info_card.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/screen_utils/screen_util.dart';
import '../../logic/cubit/team_support/team_support_cubit.dart';


class TeamSupportScreen extends StatefulWidget {


  const TeamSupportScreen({Key? key})
      : super(key: key);

  @override
  _TeamSupportScreen createState() => _TeamSupportScreen();
}

class _TeamSupportScreen extends State<TeamSupportScreen> {
  late final TeamSupportCubit _teamSupportCubit;

  @override
  void initState() {
    super.initState();
    _teamSupportCubit = getItInstance<TeamSupportCubit>();
    _teamSupportCubit.loadTeamSupportData();
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
      child:  Center(
        child: SingleChildScrollView(
          child: BlocBuilder<TeamSupportCubit, TeamSupportState>(
            builder: (context, state) {

              /// loading
              if (state is LoadingTeamSupportState) {
                return const Center(
                  child: LoadingWidget(),
                );
              }

              /// error
              if (state is TeamSupportErrorState) {
                return Center(
                  child: Text(
                    "Error: ${state.appError.appErrorType} , message: ${state.appError.message}",
                  ),
                );
              }

              /// TeamSupportDataLoaded
              if (state is TeamSupportDataLoaded) {
                final developerData = state.teamSupportEntity;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil.screenWidth * 0.1,vertical: Sizes.dimen_4.h),
                  child: Column(
                    children: [
                      /// image
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: ScreenUtil.screenHeight * 0.35,
                          maxWidth: ScreenUtil.screenWidth * 0.7,
                          minHeight: ScreenUtil.screenHeight * 0.35,
                          minWidth: ScreenUtil.screenWidth * 0.7,
                        ),
                        margin: EdgeInsets.only(bottom: Sizes.dimen_10.h),
                        child: DeveloperContactImage(
                            imageUrl: developerData.image),
                      ),

                      /// contact data card
                      TeamSupportCardInfo(
                        teamSupportEntity: state.teamSupportEntity,
                      )
                    ],
                  ),
                );
              }

              /// Nothing to show
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
