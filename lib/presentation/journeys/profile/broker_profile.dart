import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
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
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/enums/user_types.dart';
import '../../../di/git_it.dart';
import '../../../domain/entities/arguments/complete_broker_data_arguments.dart';
import '../../logic/cubit/get_broker_by_id/get_broker_by_id_cubit.dart';
import '../../themes/theme_color.dart';
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
                return ButtonWithBoxShadow(
                  text: TranslateConstants.completeYourProfile.t(context),
                  onPressed: () => _navigateToCompleteBrokerData(
                    userEntity: state.userEntity,
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        UserDataItem(
                          keyData: TranslateConstants.phoneNumber.t(context),
                          value: state.userEntity.phoneNumber,
                        ),
                        Container(
                          width: 30,
                        ),
                        UserDataItem(
                          keyData:
                              TranslateConstants.experienceYears.t(context),
                          value: state.userEntity.experienceYears.toString(),
                        ),
                      ],
                    ),
                    Text(TranslateConstants.favoriteRegions.t(context),
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              //letterSpacing: 0.5,
                              fontWeight: FontWeight.normal,
                              color: AppColor.geeBung,
                            )),

                    // GridView.builder(
                    //     scrollDirection: Axis.vertical,
                    //     shrinkWrap: true,
                    //     itemCount: 10,//state.userEntity.favoriteAreas.length,
                    //     physics: const BouncingScrollPhysics(),
                    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //       crossAxisCount: 2,
                    //       mainAxisSpacing: Sizes.dimen_8.w,
                    //       childAspectRatio: 5,
                    //       // childAspectRatio: ResponsiveValue<double>(context,
                    //       //     defaultValue: 0.9,
                    //       //     valueWhen: const [
                    //       //       Condition.equals(name: TABLET, value: 0.7),
                    //       //       Condition.largerThan(name: TABLET, value: 0.7),
                    //       //       Condition.equals(name: MOBILE, value: 0.9),
                    //       //       Condition.smallerThan(name: MOBILE, value: 0.9),
                    //       //     ]).value!,
                    //       crossAxisSpacing: Sizes.dimen_8.w,
                    //     ),
                    //     itemBuilder: (context, index) {
                    //       return Container(
                    //         padding: const EdgeInsets.all(5),
                    //         decoration: BoxDecoration(
                    //             color: AppColor.transparentGeeBung
                    //                 .withOpacity(0.18),
                    //             borderRadius: BorderRadius.circular(
                    //                 AppUtils.cornerRadius.w)),
                    //         child: Center(
                    //           child: Text(
                    //             state.userEntity.favoriteAreas[1].name,
                    //           ),
                    //         ),
                    //       );
                    //     }),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: constraints.maxWidth > 700 ? 4 : 3,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 3,
                              childAspectRatio: 2
                            ),
                            itemCount: state.userEntity.favoriteAreas.length,
                            itemBuilder: (context,index){
                              return  Container(
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
                      }
                    ),
                    // ListView.builder(
                    //   physics: const BouncingScrollPhysics(),
                    //     shrinkWrap: true,
                    //     itemCount: 10,//state.userEntity.favoriteAreas.length,
                    //     itemBuilder: (context, index) {
                    //       return Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //       Container(
                    //             padding: const EdgeInsets.all(5),
                    //             decoration: BoxDecoration(
                    //                 color: AppColor.transparentGeeBung
                    //                     .withOpacity(0.18),
                    //                 borderRadius: BorderRadius.circular(
                    //                     AppUtils.cornerRadius.w)),
                    //             child: Center(
                    //               child: Text(
                    //                 state.userEntity.favoriteAreas[1].name,
                    //               ),
                    //             ),
                    //           ),
                    //           Text(
                    //             state.userEntity.favoriteAreas[0].name,
                    //           ),
                    //           Text(
                    //             state.userEntity.favoriteAreas[0].name,
                    //           ),
                    //           Text(
                    //             state.userEntity.favoriteAreas[0].name,
                    //           ),
                    //           Text(
                    //             state.userEntity.favoriteAreas[0].name,
                    //           ),
                    //           Text(
                    //             state.userEntity.favoriteAreas[0].name,
                    //           ),
                    //         ],
                    //       );
                    //     })
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
