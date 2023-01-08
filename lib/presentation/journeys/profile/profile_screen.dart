import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/data/data_sources/remote_data_source.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/journeys/profile/broker_profile.dart';
import 'package:remax_mapstate/presentation/journeys/profile/user_data_item.dart';
import 'package:remax_mapstate/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:remax_mapstate/presentation/logic/cubit/get_broker_by_id/get_broker_by_id_cubit.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/city_background_widget.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../../common/constants/translate_constatns.dart';
import '../../widgets/btn_with_box_shadow.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final AuthorizedUserCubit _authorizedUserCubit;
  late final GetBrokerByIdCubit _getBrokerByIdCubit;

  @override
  void initState() {
    super.initState();
    _authorizedUserCubit = getItInstance<AuthorizedUserCubit>();
    _authorizedUserCubit.loadCurrentAuthorizedUserData();

    _getBrokerByIdCubit = getItInstance<GetBrokerByIdCubit>();
  }

  @override
  void dispose() {
    _authorizedUserCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getBroker();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _authorizedUserCubit),
        BlocProvider(create: (context) => _getBrokerByIdCubit),
      ],
      child: Builder(builder: (context) {
        return BlocConsumer<AuthorizedUserCubit, AuthorizedUserState>(
          listener: (context, state) {
            // if (state.userEntity.id != "-1") {
            //   _getBrokerByIdCubit.getBrokerById(
            //       brokerId: int.parse(state.userEntity.id));
            // }
          },
          builder: (context, state) {
            return Stack(
              children: [
                //==> background image
                const CityBackgroundWidget(),

                Padding(
                  padding: EdgeInsets.only(top: Sizes.dimen_18.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColor.transparentGeeBung,
                        radius: 100,
                        backgroundImage: AssetImage(AssetsConstants.person2),
                      ),


                      /// userData
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.only(top: Sizes.dimen_22.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                UserDataItem(
                                  keyData: TranslateConstants.fullName.t(context),
                                  value: state.userEntity.firstName,
                                ),
                                UserDataItem(
                                  keyData: TranslateConstants.email.t(context),
                                  value: state.userEntity.email,
                                ),

                                /// broker profile
                                if (state is CurrentBrokerAuthorizedUserData)
                                  BrokerProfile(
                                    brokerId: state.userEntity.id,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }

  List<Widget> _userData({
    required String firstName,
    required String email,
  }) {
    return [
      UserDataItem(
        keyData: "Name",
        value: firstName,
      ),
      UserDataItem(
        keyData: "Email",
        value: email,
      ),
    ];
  }

  void _getBroker() async {
    final dataSource = getItInstance<RemoteDataSource>();
    final result = await dataSource.getBrokerById(0);

    log("Result From Profile >>>>> $result");
  }
}
