import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/functions/show_snack_bar.dart';
import 'package:remax_mapstate/domain/entities/authorized_user_entity.dart';
import 'package:remax_mapstate/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:remax_mapstate/presentation/logic/cubit/update_default_user/update_default_user_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';
import 'package:remax_mapstate/presentation/widgets/stack_with_full_background.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/constants/translate_constatns.dart';
import '../../../di/git_it.dart';
import '../../../domain/entities/arguments/register_or_login_args.dart';
import '../../../router/route_hepler.dart';
import '../../logic/cubit/auth/get_profile/get_current_user_profile_cubit.dart';
import '../../logic/cubit/choose_favorite_area/choose_favorite_area_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/logo_with_slogan.dart';
import '../../widgets/text_login_instead.dart';

import 'login_form.dart';
import 'registration_form.dart';

class RegisterOrLoginScreen extends StatefulWidget {
  final RegisterOrLoginArguments registerOrLoginArguments;

  const RegisterOrLoginScreen(
      {Key? key, required this.registerOrLoginArguments})
      : super(key: key);

  @override
  _RegisterOrLoginScreenState createState() => _RegisterOrLoginScreenState();
}

class _RegisterOrLoginScreenState extends State<RegisterOrLoginScreen> {
  /// ChooseFavoriteAreaCubit
  late final ChooseFavoriteAreaCubit _chooseFavoriteAreaCubit;

  /// GetCurrentUserProfileCubit
  late final GetCurrentUserProfileCubit _getCurrentUserProfileCubit;

  /// UpdateDefaultUserCubit
  late final UpdateDefaultUserCubit _updateDefaultUserCubit;

  /// user type
  UserType currentRegisteredUserType = UserType.unDefined;

  /// to change between login or registration
  bool isLoginForm = true;

  String userEmail = "";
  String userPassword = "";

  @override
  void initState() {
    super.initState();
    _chooseFavoriteAreaCubit = getItInstance<ChooseFavoriteAreaCubit>();
    _getCurrentUserProfileCubit = getItInstance<GetCurrentUserProfileCubit>();
    _updateDefaultUserCubit = getItInstance<UpdateDefaultUserCubit>();
  }

  @override
  void dispose() {
    _chooseFavoriteAreaCubit.close();
    _getCurrentUserProfileCubit.close();
    _updateDefaultUserCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getCurrentUserProfileCubit),
        BlocProvider(create: (context) => _updateDefaultUserCubit),
      ],
      child: MultiBlocListener(
        listeners: [
          //==> listener on UpdateDefaultUserCubit
          BlocListener<UpdateDefaultUserCubit, UpdateDefaultUserState>(
              listener: (context, state) async {
            if (state is ErrorWhileUpdatingDefaultUser) {
              log("ErrorWhileUpdatingDefaultUser >>  ${state.appError}");
              showSnackBar(
                context,
                message: TranslateConstants.somethingWentWrong.t(context),
              );
            }
            if (state is SuccessUpdateDefaultUser) {
              log("SuccessUpdateDefaultUser >>");

              await _saveAuthorizedUser(
                authorizedUserEntity:
                    AuthorizedUserEntity.fromUserEntity(state.userEntity),
              );

              //==> navigate to login
              _navigateToMainScreen();
            }
          }),

          //==> listener on GetCurrentUserProfileCubit
          BlocListener<GetCurrentUserProfileCubit, GetCurrentUserProfileState>(
            listener: (context, state) {
              if (state is ErrorWhileFetchingProfile) {
                log("ErrorWhileFetchingProfile ${state.appError}");
                showSnackBar(
                  context,
                  message: TranslateConstants.somethingWentWrong.t(context),
                );
              }
              if (state is UnAuthorizedToGetProfile) {
                log("UnAuthorizedToGetProfile >>");
                showSnackBar(
                  context,
                  message: TranslateConstants.somethingWentWrong.t(context),
                );
              }
              if (state is ProfileDataFetchedSuccessfully) {
                log("ProfileDataFetchedSuccessfully >>");
                // update user data with the user type
                _updateUserGroup(
                  userId: state.profileEntity.userEntity.id,
                  userType: currentRegisteredUserType,
                );
              }
            },
          ),
        ],
        child: StackScaffoldWithFullBackground(
          appBarTitle: isLoginForm
              ? Text(TranslateConstants.login.t(context))
              : Text(TranslateConstants.brokerRegistration.t(context)),
          body: BlocBuilder<UpdateDefaultUserCubit, UpdateDefaultUserState>(
            builder: (context, updateUserDataState) {
              return BlocBuilder<GetCurrentUserProfileCubit,
                  GetCurrentUserProfileState>(
                builder: (context, getProfileState) {
                  return Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: Sizes.dimen_10.h,
                          left: Sizes.dimen_32.w,
                          right: Sizes.dimen_32.w,
                        ),
                        child: Column(
                          children: [
                            /// Logo with slogan
                            LogoWithSlogan(
                              margin: EdgeInsets.only(
                                top: Sizes.dimen_12.h,
                                bottom: Sizes.dimen_20.h,
                              ),
                            ),

                            /// register Form

                            Flexible(
                              child: isLoginForm
                                  ? LoginForm(
                                      email: userEmail,
                                      password: userPassword,
                                      onSuccessLogin: (userToken,
                                          authorizedUserEntity) async {
                                        //==> save current user token
                                        await _saveTokenForAutoLogin(
                                            token: userToken);

                                        //==> save current authorized user
                                        log("UserEntity: $authorizedUserEntity");
                                        authorizedUserEntity.userType = widget
                                            .registerOrLoginArguments.userType;
                                        await _saveAuthorizedUser(
                                          authorizedUserEntity:
                                              authorizedUserEntity,
                                        );

                                        //==> navigate to login
                                        _navigateToMainScreen();
                                      },
                                    )
                                  : RegisterForm(
                                      userType: widget
                                          .registerOrLoginArguments.userType,
                                      onRegistrationSuccess:
                                          (registerEntity, userType) async {
                                        // update data
                                        currentRegisteredUserType = userType;

                                        //==> save user token
                                        await _saveTokenForAutoLogin(
                                          token: registerEntity.userToken,
                                        );

                                        //==> to get profile
                                        _getProfileData(
                                          userToken: registerEntity.userToken,
                                        );

                                        //_changeBetweenLoginAndRegistration();
                                      },
                                    ),
                            ),

                            TextLoginInstead(
                              isLogin: isLoginForm,
                              onPressed: () =>
                                  _changeBetweenLoginAndRegistration(),
                            ),
                          ],
                        ),
                      ),

                      /// show loading
                      if (getProfileState is LoadingToGetProfile ||
                          updateUserDataState is LoadingToUpdateDefaultUser)
                        Center(
                          child: Container(
                            color: AppColor.black.withOpacity(0.3),
                            child: const Center(
                              child: LoadingWidget(),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  /// get profile data
  void _getProfileData({required String userToken}) {
    _getCurrentUserProfileCubit.getCurrentUserProfile(userToken: userToken);
  }

  /// to update user group
  void _updateUserGroup({
    required String userId,
    required UserType userType,
  }) {
    _updateDefaultUserCubit.updateUserGroupId(
      userId: userId,
      currentUserType: userType,
      userToken: "",
    );
  }

  /// to change between login and registration
  void _changeBetweenLoginAndRegistration() => setState(() {
        isLoginForm = !isLoginForm;
      });

  /// to save token for auto login
  Future<void> _saveTokenForAutoLogin({required String token}) =>
      context.read<UserTokenCubit>().save(token);

  /// to save the current authorized user
  Future<void> _saveAuthorizedUser(
          {required AuthorizedUserEntity authorizedUserEntity}) =>
      context.read<AuthorizedUserCubit>().save(authorizedUserEntity);

  /// Navigate to MainScreen
  void _navigateToMainScreen() =>
      RouteHelper().mainScreen(context, isClearStack: true);
}
