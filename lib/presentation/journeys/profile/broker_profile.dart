import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/arguments/register_or_login_args.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';
import 'package:remax_mapstate/presentation/journeys/profile/user_data_item.dart';
import 'package:remax_mapstate/presentation/widgets/app_error_widget.dart';
import 'package:remax_mapstate/router/route_hepler.dart';

import '../../../common/enums/user_types.dart';
import '../../../di/git_it.dart';
import '../../logic/cubit/get_broker_by_id/get_broker_by_id_cubit.dart';
import '../../widgets/btn_with_box_shadow.dart';
import '../../widgets/loading_widget.dart';

class BrokerProfile extends StatefulWidget {
  final String brokerId;

  const BrokerProfile({Key? key, required this.brokerId}) : super(key: key);

  @override
  State<BrokerProfile> createState() => _BrokerProfileState();
}

class _BrokerProfileState extends State<BrokerProfile> {
  late final GetBrokerByIdCubit _getBrokerByIdCubit;

  @override
  void initState() {
    super.initState();
    _getBrokerByIdCubit = getItInstance<GetBrokerByIdCubit>();
    _fetchBrokerData();
  }

  @override
  void dispose() {
    _getBrokerByIdCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getBrokerByIdCubit,
      child: Builder(builder: (context) {
        return BlocBuilder<GetBrokerByIdCubit, GetBrokerByIdState>(
          builder: (context, state) {
            /*
            *
            *
            * loading
            *
            *
            * */
            if (state is LoadingGetBrokerById) {
              return const LoadingWidget();
            }

            /*
            *
            *
            * data fetched but need to completed data
            *
            *
            * */
            if (state is NotCompletedDataForBroker) {
              return ButtonWithBoxShadow(
                text: TranslateConstants.completeYourProfile.t(context),
                onPressed: () {},
              );
            }

            /*
            *
            *
            * data fetched with completed data
            *
            *
            * */
            if (state is BrokerDataFetched) {
              return Column(
                children: [
                  UserDataItem(
                    keyData: TranslateConstants.phoneNumber.t(context),
                    value: state.userEntity.phoneNumber,
                  ),
                  UserDataItem(
                    keyData: TranslateConstants.experienceYears.t(context),
                    value: state.userEntity.experienceYears.toString(),
                  ),
                ],
              );
            }

            /*
            *
            *
            * unAuthorized
            *
            *
            * */
            if (state is UnAuthorizedToGetBrokerById) {
              return AppErrorWidget(
                withCard: false,
                appTypeError: AppErrorType.unAuthorized,
                buttonText: TranslateConstants.login.t(context),
                onPressedRetry: () => _navigateToLogin(),
              );
            }

            /*
            *
            *
            * Not a broker before getting broker by id
            * broker id (-1)
            * this means that the saved authorized user in the preferences
            * have not valid data
            * solution >>  try to login again
            *
            *
            * */
            if (state is NotABrokerBeforeGettingBrokerById) {
              return AppErrorWidget(
                withCard: false,
                appTypeError: AppErrorType.unAuthorized,
                buttonText: TranslateConstants.login.t(context),
                onPressedRetry: () => _navigateToLogin(),
              );
            }

            /*
            *
            *
            * error
            *
            *
            * */
            if (state is ErrorWhileGettingBrokerById) {
              return AppErrorWidget(
                withCard: false,
                appTypeError: state.appError.appErrorType,
                onPressedRetry: () => _fetchBrokerData(),
              );
            }

            /*
            *
            *
            * else
            *
            *
            * */
            return const SizedBox.shrink();
          },
        );
      }),
    );
  }

  /// return true if user data need to update
  bool _isProfileNeedToUpdateUser(UserEntity userEntity) {
    final phoneNum = userEntity.phoneNumber;
    final yearsOfExperience = userEntity.experienceYears;
    final favAreas = userEntity.favoriteAreas;

    // check of any of these need to update
    return phoneNum == AppUtils.undefined ||
        yearsOfExperience == -1 ||
        favAreas.isEmpty;
  }

  /// to fetch broker data
  void _fetchBrokerData() {
    _getBrokerByIdCubit.getBrokerById(
      brokerId: widget.brokerId,
    );
  }

  /// to navigate to login
  void _navigateToLogin() {
    RouteHelper().registerOrLoginScreen(
      context,
      registerOrLoginArguments: RegisterOrLoginArguments(
        userType: UserType.broker,
      ),
      removeAllScreens: true,
    );
  }
}
