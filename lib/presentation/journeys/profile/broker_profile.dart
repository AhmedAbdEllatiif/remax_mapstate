import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/arguments/register_or_login_args.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';
import 'package:remax_mapstate/presentation/journeys/profile/user_data_item.dart';
import 'package:remax_mapstate/presentation/logic/cubit/complete_broker_data/complete_broker_data_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/app_error_widget.dart';
import 'package:remax_mapstate/router/route_hepler.dart';
import '../../../common/enums/user_types.dart';
import '../../../di/git_it.dart';
import '../../../domain/entities/arguments/complete_broker_data_arguments.dart';
import '../../logic/cubit/get_broker_by_id/get_broker_by_id_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/btn_with_box_shadow.dart';
import '../../widgets/image_name_rating_widget.dart';
import '../../widgets/loading_widget.dart';

class BrokerProfile extends StatefulWidget {
  final String brokerId;

  const BrokerProfile({Key? key, required this.brokerId}) : super(key: key);

  @override
  State<BrokerProfile> createState() => _BrokerProfileState();
}

class _BrokerProfileState extends State<BrokerProfile> {
  late final GetBrokerByIdCubit _getBrokerByIdCubit;
  late final CompleteBrokerDataCubit _completeBrokerDataCubit;

  @override
  void initState() {
    super.initState();
    _getBrokerByIdCubit = getItInstance<GetBrokerByIdCubit>();
    _completeBrokerDataCubit = getItInstance<CompleteBrokerDataCubit>();
    _fetchBrokerData();
  }

  @override
  void dispose() {
    _getBrokerByIdCubit.close();
    _completeBrokerDataCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getBrokerByIdCubit),
        BlocProvider(create: (context) => _completeBrokerDataCubit),
      ],
      child: Builder(builder: (context) {
        return BlocListener<CompleteBrokerDataCubit, CompleteBrokerDataState>(
          listener: (context, state) {
            if (state is BrokerDataCompletedSuccessfully) {
              _fetchBrokerData();
            }
          },
          child: BlocBuilder<GetBrokerByIdCubit, GetBrokerByIdState>(
            builder: (context, state) {
              /*
            *
            *
            * loading
            *
            *
            * */
              if (state is LoadingGetBrokerById) {
                return const Center(child: LoadingWidget());
              }

              /*
            *
            *
            * data fetched but need to completed data
            *
            *
            * */
              if (state is NotCompletedDataForBroker) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: ImageNameRatingWidget(
                          imgUrl: state.userEntity.avatar,
                          name: state.userEntity.firstName,
                          nameStyle:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.white,
                                  ),
                          rating: state.userEntity.brokerRating,
                        ),
                      ),
                      UserDataItem(
                        keyData: TranslateConstants.email.t(context),
                        value: state.userEntity.email,
                      ),
                      UserDataItem(
                        keyData: TranslateConstants.phoneNumber.t(context),
                        value: state.userEntity.phoneNumber,
                      ),
                      ButtonWithBoxShadow(
                        text: TranslateConstants.completeYourProfile.t(context),
                        onPressed: () => _navigateToCompleteBrokerData(
                          userEntity: state.userEntity,
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
              if (state is BrokerDataFetched) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: ImageNameRatingWidget(
                          imgUrl: state.userEntity.avatar,
                          name: state.userEntity.firstName,
                          nameStyle:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.white,
                                  ),
                          rating: state.userEntity.brokerRating,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: UserDataItem(
                              keyData:
                                  TranslateConstants.phoneNumber.t(context),
                              value: state.userEntity.phoneNumber,
                            ),
                          ),
                          Container(
                            width: 30,
                          ),
                          // Expanded(
                          //   child: UserDataItem(
                          //     keyData:
                          //         TranslateConstants.experienceYears.t(context),
                          //     value:
                          //         state.userEntity.experienceYears.toString(),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: Sizes.dimen_6.h,
                      ),
                      Text(TranslateConstants.favoriteRegions.t(context),
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    //letterSpacing: 0.5,
                                    fontWeight: FontWeight.normal,
                                    color: AppColor.geeBung,
                                  )),
                      LayoutBuilder(builder: (context, constraints) {
                        return GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      constraints.maxWidth > 700 ? 4 : 3,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 3,
                                  childAspectRatio: 3),
                          itemCount: state.userEntity.favoriteAreas.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: AppColor.transparentGeeBung
                                      .withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(
                                      AppUtils.cornerRadius.w)),
                              child: Center(
                                child: Text(
                                  state.userEntity.favoriteAreas[index].name,
                                ),
                              ),
                            );
                          },
                        );
                      }),
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
              if (state is UnAuthorizedToGetBrokerById) {
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
            * Not a broker before getting broker by id
            * broker id (-1)
            * this means that the saved authorized user in the preferences
            * have not valid data
            * solution >>  try to login again
            *
            *
            * */
              if (state is NotABrokerBeforeGettingBrokerById) {
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
              if (state is ErrorWhileGettingBrokerById) {
                return Center(
                  child: AppErrorWidget(
                    withCard: false,
                    appTypeError: state.appError.appErrorType,
                    onPressedRetry: () => _fetchBrokerData(),
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

  /// to fetch broker data
  void _fetchBrokerData() {
    _getBrokerByIdCubit.getBrokerById(
      context,
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

  /// to navigate to complete broker data
  void _navigateToCompleteBrokerData({required UserEntity userEntity}) {
    RouteHelper().completeBrokerData(context,
        completeBrokerDataArguments: CompleteBrokerDataArguments(
          userEntity: userEntity,
          completeBrokerDataCubit: _completeBrokerDataCubit,
        ));
  }
}
