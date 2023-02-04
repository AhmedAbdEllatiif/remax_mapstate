import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/arguments/register_or_login_args.dart';
import 'package:remax_mapstate/presentation/journeys/profile/user_avatar_widget.dart';
import 'package:remax_mapstate/presentation/journeys/profile/user_data_item.dart';
import 'package:remax_mapstate/presentation/widgets/app_error_widget.dart';
import 'package:remax_mapstate/router/route_hepler.dart';
import '../../../common/enums/user_types.dart';
import '../../../di/git_it.dart';
import '../../logic/cubit/get_buyer_by_id/get_buyer_by_id_cubit.dart';
import '../../logic/cubit/update_default_user/update_default_user_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/image_name_rating_widget.dart';
import '../../widgets/loading_widget.dart';

class BuyerProfile extends StatefulWidget {
  final String buyerId;

  const BuyerProfile({Key? key, required this.buyerId}) : super(key: key);

  @override
  State<BuyerProfile> createState() => _BuyerProfileState();
}

class _BuyerProfileState extends State<BuyerProfile> {
  late final GetBuyerByIdCubit _getBuyerByIdCubit;
  late final UpdateDefaultUserCubit _updateDefaultUserCubit;

  @override
  void initState() {
    super.initState();
    _getBuyerByIdCubit = getItInstance<GetBuyerByIdCubit>();
    _updateDefaultUserCubit = getItInstance<UpdateDefaultUserCubit>();
    _fetchBuyerData();
  }

  @override
  void dispose() {
    _getBuyerByIdCubit.close();
    _updateDefaultUserCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getBuyerByIdCubit),
      ],
      child: Builder(builder: (context) {
        return BlocBuilder<GetBuyerByIdCubit, GetBuyerByIdState>(
          builder: (context, state) {
            /*
            *
            *
            * loading
            *
            *
            * */
            if (state is LoadingGetBuyerById) {
              return const Center(child: LoadingWidget());
            }

            /*
            *
            *
            * data fetched with completed data
            *
            *
            * */
            if (state is BuyerDataFetched) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: UserAvatarWidget(
                        userId: state.userEntity.id,
                        updateDefaultUserCubit: _updateDefaultUserCubit,
                        avatarUrl: state.userEntity.avatar,
                        userName: state.userEntity.firstName,
                        rating: 0,
                        showRating: false,
                        // rating: state.userEntity.brokerRating,
                      ),
                    ),
                    SizedBox(
                      height: Sizes.dimen_10.h,
                    ),
                    UserDataItem(
                      keyData: TranslateConstants.email.t(context),
                      value: state.userEntity.email,
                    ),
                    SizedBox(
                      height: Sizes.dimen_6.h,
                    ),
                    UserDataItem(
                      keyData: TranslateConstants.phoneNumber.t(context),
                      value: state.userEntity.phoneNumber,
                      forceLTR: true,
                    ),
                  ],
                ),
              );
            }

            /*
            *
            *
            * unAuthorized
            *
            *
            * */
            if (state is UnAuthorizedToGetBuyerById) {
              return Center(
                child: AppErrorWidget(
                  withCard: false,
                  appTypeError: AppErrorType.unAuthorized,
                  buttonText: TranslateConstants.login.t(context),
                  onPressedRetry: () => _navigateToLogin(),
                ),
              );
            }

            /*
            *
            *
            * Not a Buyer before getting Buyer by id
            * Buyer id (-1)
            * this means that the saved authorized user in the preferences
            * have not valid data
            * solution >>  try to login again
            *
            *
            * */
            if (state is NotABuyerBeforeGettingBuyerById) {
              return Center(
                child: AppErrorWidget(
                  withCard: false,
                  appTypeError: AppErrorType.unAuthorized,
                  buttonText: TranslateConstants.login.t(context),
                  onPressedRetry: () => _navigateToLogin(),
                ),
              );
            }

            /*
            *
            *
            * error
            *
            *
            * */
            if (state is ErrorWhileGettingBuyerById) {
              return Center(
                child: AppErrorWidget(
                  withCard: false,
                  appTypeError: state.appError.appErrorType,
                  onPressedRetry: () => _fetchBuyerData(),
                ),
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

  /// to fetch Buyer data
  void _fetchBuyerData() {
    _getBuyerByIdCubit.getBuyerById(
      buyerId: widget.buyerId,
    );
  }

  /// to navigate to login
  void _navigateToLogin() {
    RouteHelper().registerOrLoginScreen(
      context,
      registerOrLoginArguments: RegisterOrLoginArguments(
        userType: UserType.client,
      ),
      removeAllScreens: true,
    );
  }
}
