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
import 'package:remax_mapstate/presentation/journeys/profile/buyer_profile.dart';
import 'package:remax_mapstate/presentation/journeys/profile/user_data_item.dart';
import 'package:remax_mapstate/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:remax_mapstate/presentation/logic/cubit/get_broker_by_id/get_broker_by_id_cubit.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/city_background_widget.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../../common/constants/translate_constatns.dart';
import '../../widgets/btn_with_box_shadow.dart';
import '../../widgets/image_name_rating_widget.dart';

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
                //const CityBackgroundWidget(),

                Padding(
                  padding: EdgeInsets.only(
                    top: Sizes.dimen_18.h,
                    right: Sizes.dimen_10.w,
                    left: Sizes.dimen_10.w,
                  ),
                  child: state is CurrentBuyerAuthorizedUserData
                      ? BuyerProfile(buyerId: state.authorizedUserEntity.id)
                      : state is CurrentBrokerAuthorizedUserData
                          ? BrokerProfile(
                              brokerId: state.authorizedUserEntity.id)
                          : const SizedBox.shrink(),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
