import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/functions/get_current_app_language.dart';
import 'package:remax_mapstate/common/functions/get_user_token.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/arguments/register_or_login_args.dart';
import 'package:remax_mapstate/presentation/journeys/profile/user_avatar_widget.dart';
import 'package:remax_mapstate/presentation/journeys/profile/user_data_item.dart';
import 'package:remax_mapstate/presentation/logic/cubit/update_default_user/update_default_user_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/app_error_widget.dart';
import 'package:remax_mapstate/router/route_hepler.dart';
import '../../../common/enums/user_types.dart';
import '../../../di/git_it.dart';
import '../../../domain/entities/users/ambassador_entity.dart';
import '../../logic/cubit/complete_ambassador_date/complete_ambassador_data_cubit.dart';
import '../../logic/cubit/get_ambassador_by_id/get_ambassador_by_id_cubit.dart';
import '../../widgets/btn_with_box_shadow.dart';
import '../../widgets/loading_widget.dart';

class AmbassadorProfile extends StatefulWidget {
  final String ambassadorId;

  const AmbassadorProfile({Key? key, required this.ambassadorId})
      : super(key: key);

  @override
  State<AmbassadorProfile> createState() => _AmbassadorProfileState();
}

class _AmbassadorProfileState extends State<AmbassadorProfile> {
  late final GetAmbassadorByIdCubit _getAmbassadorByIdCubit;
  late final CompleteAmbassadorDataCubit _completeAmbassadorDataCubit;
  late final UpdateDefaultUserCubit _updateDefaultUserCubit;

  @override
  void initState() {
    super.initState();
    _getAmbassadorByIdCubit = getItInstance<GetAmbassadorByIdCubit>();
    _completeAmbassadorDataCubit = getItInstance<CompleteAmbassadorDataCubit>();
    _updateDefaultUserCubit = getItInstance<UpdateDefaultUserCubit>();
    _fetchAmbassadorData();
  }

  @override
  void dispose() {
    _getAmbassadorByIdCubit.close();
    _completeAmbassadorDataCubit.close();
    _updateDefaultUserCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getAmbassadorByIdCubit),
        BlocProvider(create: (context) => _completeAmbassadorDataCubit),
        BlocProvider(create: (context) => _updateDefaultUserCubit),
      ],
      child: Builder(builder: (context) {
        return BlocListener<CompleteAmbassadorDataCubit,
            CompleteAmbassadorDataState>(
          listener: (context, state) {
            if (state is AmbassadorDataCompletedSuccessfully) {
              _fetchAmbassadorData();
            }
          },
          child: BlocBuilder<GetAmbassadorByIdCubit, GetAmbassadorByIdState>(
            builder: (context, state) {
              /*
            *
            *
            * loading
            *
            *
            * */
              if (state is LoadingGetAmbassadorById) {
                return const Center(child: LoadingWidget());
              }


              /*
              *
              *
              * ambassador not found
              *
              * */
              if (state is AmbassadorNotFoundById) {
                return Center(
                  child: AppErrorWidget(
                    withCard: false,
                    appTypeError: AppErrorType.userNotFound,
                    buttonText: TranslateConstants.retry.t(context),
                    onPressedRetry: () => _navigateToLogin(),
                  ),
                );
              }


              /*
            *
            *
            * data fetched but need to completed data
            *
            *
            * */
              if (state is NotCompletedDataForAmbassador) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: UserAvatarWidget(
                          userId: widget.ambassadorId,
                          updateDefaultUserCubit: _updateDefaultUserCubit,
                          avatarUrl: state.ambassadorEntity.avatar,
                          userName: state.ambassadorEntity.firstName,
                          rating: 0,
                          showRating: false,
                        ),
                      ),
                      UserDataItem(
                        keyData: TranslateConstants.email.t(context),
                        value: state.ambassadorEntity.email,
                      ),
                      UserDataItem(
                        keyData: TranslateConstants.phoneNumber.t(context),
                        value: state.ambassadorEntity.phoneNumber,
                        forceLTR: true,
                      ),
                      ButtonWithBoxShadow(
                        text: TranslateConstants.completeYourProfile.t(context),
                        onPressed: () => _navigateToCompleteAmbassadorData(
                          ambassadorEntity: state.ambassadorEntity,
                        ),
                      ),
                    ],
                  ),
                );
              }

              /*
            *
            *
            * data fetched with completed data
            *
            *
            * */
              if (state is AmbassadorDataFetched) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: UserAvatarWidget(
                          userId: widget.ambassadorId,
                          updateDefaultUserCubit: _updateDefaultUserCubit,
                          avatarUrl: state.ambassadorEntity.avatar,
                          userName: state.ambassadorEntity.firstName,
                          rating: 0,
                          showRating: false,
                        ),
                      ),
                      SizedBox(
                        height: Sizes.dimen_10.h,
                      ),
                      UserDataItem(
                        keyData: TranslateConstants.email.t(context),
                        value: state.ambassadorEntity.email,
                      ),
                      SizedBox(
                        height: Sizes.dimen_6.h,
                      ),

                      //==> phoneNum and experience years
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: UserDataItem(
                              keyData:
                                  TranslateConstants.phoneNumber.t(context),
                              value: state.ambassadorEntity.phoneNumber,
                            ),
                          ),
                          Container(
                            width: 30,
                          ),
                        ],
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
              if (state is UnAuthorizedToGetAmbassadorById) {
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
            * Not a Ambassador before getting Ambassador by id
            * Ambassador id (-1)
            * this means that the saved authorized user in the preferences
            * have not valid data
            * solution >>  try to login again
            *
            *
            * */
              if (state is NotAAmbassadorBeforeGettingAmbassadorById) {
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
              if (state is ErrorWhileGettingAmbassadorById) {
                return Center(
                  child: AppErrorWidget(
                    withCard: false,
                    appTypeError: state.appError.appErrorType,
                    onPressedRetry: () => _fetchAmbassadorData(),
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
          ),
        );
      }),
    );
  }

  /// to fetch Ambassador data
  void _fetchAmbassadorData() {
    final userToken = getUserToken(context);
    final appLanguage = getCurrentAppLanguage(context);

    _getAmbassadorByIdCubit.tryToGetAmbassadorById(
      ambassadorId: widget.ambassadorId,
      userToken: userToken,
      appLanguage: appLanguage,
    );
  }

  /// to navigate to login
  void _navigateToLogin() {
    RouteHelper().registerOrLoginScreen(
      context,
      registerOrLoginArguments: RegisterOrLoginArguments(
        userType: UserType.ambassador,
      ),
      removeAllScreens: true,
    );
  }

  /// to navigate to complete Ambassador data
  void _navigateToCompleteAmbassadorData(
      {required AmbassadorEntity ambassadorEntity}) {
    // RouteHelper().completeAmbassadorData(context,
    //     completeAmbassadorDataArguments: CompleteAmbassadorDataArguments(
    //       ambassadorEntity: ambassadorEntity,
    //       completeAmbassadorDataCubit: _completeAmbassadorDataCubit,
    //     ));
  }
}
