import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/functions/get_current_app_language.dart';
import 'package:remax_mapstate/common/functions/get_user_token.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/journeys/choose_broker/arguments/choose_broker_argument.dart';
import 'package:remax_mapstate/presentation/journeys/choose_broker/brokers_page_view/top_broker_page_view_widget.dart';
import 'package:remax_mapstate/presentation/logic/cubit/get_brokers_by_area/get_brokers_by_area_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/app_error_widget.dart';
import 'package:remax_mapstate/presentation/widgets/empty_list_widegt.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';
import 'package:remax_mapstate/presentation/widgets/stack_with_full_background.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../logic/cubit/broker_changed/broker_changed_cubit.dart';
import 'bottom_card_data_holder.dart';

class ChooseBrokerScreen extends StatefulWidget {
  final ChooseBrokerArgument chooseBrokerArgument;

  const ChooseBrokerScreen({Key? key, required this.chooseBrokerArgument})
      : super(key: key);

  @override
  _ChooseBrokerScreenState createState() => _ChooseBrokerScreenState();
}

class _ChooseBrokerScreenState extends State<ChooseBrokerScreen> {
  late PageController _pageController;
  late final GetBrokersByAreaCubit areaBrokersCubit;
  late final BrokerChangedCubit brokerChangedCubit;
  late final String areaName;

  @override
  void initState() {
    super.initState();

    /// pageController
    _pageController = PageController(
      initialPage: 0,
      keepPage: false,
      viewportFraction: 0.7,
    );

    /// init areaBrokersBloc
    areaBrokersCubit = getItInstance<GetBrokersByAreaCubit>();

    /// init brokerChangedCubit
    brokerChangedCubit = getItInstance<BrokerChangedCubit>();

    areaName = widget.chooseBrokerArgument.areaName;

    _fetchBrokers();
  }

  @override
  void dispose() {
    areaBrokersCubit.close();
    brokerChangedCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetBrokersByAreaCubit>(create: (_) => areaBrokersCubit),
        BlocProvider<BrokerChangedCubit>(create: (_) => brokerChangedCubit),
      ],
      child: StackScaffoldWithFullBackground(
        /// AppBar
        appBarTitle: Text(TranslateConstants.broker.t(context)),

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocConsumer<GetBrokersByAreaCubit, GetBrokersByAreaState>(
            /// listener on AreaBrokersBloc
            listener: (context, state) {
              if (state is BrokersOfAreaFetched) {
                /// add change broker to show BottomCardDataHolder with current broker
                brokerChangedCubit.changeBroker(state.brokersList[0]);
              }
            },

            /// builder of AreaBrokersBloc
            builder: (context, state) {
              /// loading
              if (state is LoadingToGeBrokersByArea) {
                return const Center(child: LoadingWidget());
              }

              /// empty list
              if (state is EmptyListOfBrokersInThisArea) {
                return Center(
                  child: EmptyListWidget(
                      text: TranslateConstants.noBrokersToShow.t(context)),
                );
              }

              /// error
              if (state is ErrorWhileGettingBrokersByArea) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: state.appError.appErrorType,
                    onPressedRetry: () {
                      _fetchBrokers();
                    },
                  ),
                );
              }

              /// loaded
              if (state is BrokersOfAreaFetched) {
                final brokers = state.brokersList;
                return Column(
                  children: [
                    /// PageView with brokers images
                    TopBrokersPageViewWidget(
                      brokers: brokers,
                      pageController: _pageController,
                    ),

                    /// BottomCardDataHolder
                    Container(
                     // width: ScreenUtil.screenWidth * _cardWidthRatio(context),
                      width: ScreenUtil.screenWidth * 0.9,
                      height: ScreenUtil.screenHeight * 0.4,
                      margin: EdgeInsets.only(top: Sizes.dimen_20.w),
                      child: const BottomCardDataHolder(),
                    ),
                  ],
                );
              }

              /// nothing to show
              return const Center(child: SizedBox.shrink());
            },
          ),
        ),
      ),
    );
  }

  /// return the ratio of BottomCardDataHolder width
  double _cardWidthRatio(BuildContext context) {
    return ResponsiveValue<double>(context,
            defaultValue: 0.7,
            valueWhen: const [
              Condition.equals(name: TABLET, value: 0.5),
              Condition.largerThan(name: TABLET, value: 0.5),
              Condition.equals(name: MOBILE, value: 0.7),
              Condition.smallerThan(name: MOBILE, value: 0.7),
            ]).value ??
        0.55;
  }

  void _fetchBrokers() {
    final String userToken = getUserToken(context);
    final appLanguage = getCurrentAppLanguage(context);
    areaBrokersCubit.tryToGetBrokersByArea(
        userToken: userToken, regionName: areaName, appLanguage: appLanguage);
  }
}
