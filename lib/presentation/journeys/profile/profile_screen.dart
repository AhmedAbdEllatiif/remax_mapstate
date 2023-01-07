import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';
import 'package:remax_mapstate/presentation/journeys/profile/user_data_item.dart';
import 'package:remax_mapstate/presentation/logic/cubit/current_user/current_user_cubit.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/city_background_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final CurrentUserCubit _currentUserCubit;

  @override
  void initState() {
    super.initState();
    _currentUserCubit = getItInstance<CurrentUserCubit>();
  }

  @override
  void dispose() {
    _currentUserCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _currentUserCubit,
      child: Builder(builder: (context) {
        return BlocBuilder<CurrentUserCubit, UserEntity>(
          builder: (context, userEntity) {
            return Stack(
              children: [
                CityBackgroundWidget(),
                Padding(
                  padding: EdgeInsets.only(top: Sizes.dimen_18.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColor.transparentGeeBung,
                        radius: 100,
                        backgroundImage: AssetImage(AssetsConstants.person2),
                      ), //CircleAvatar

                      Padding(
                        padding: EdgeInsets.only(top: Sizes.dimen_22.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: _userData(
                            firstName: userEntity.firstName,
                            email: userEntity.email,
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
      const UserDataItem(
        keyData: "phone",
        value: "+2010058866800",
      ),
    ];
  }
}
