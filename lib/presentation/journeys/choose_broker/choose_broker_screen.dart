import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/journeys/choose_broker/arguments/choose_broker_argument.dart';
import 'package:remax_mapstate/presentation/journeys/choose_broker/brokers_page_view/top_broker_page_view_widget.dart';
import 'package:remax_mapstate/presentation/widgets/empty_list_widegt.dart';
import 'package:remax_mapstate/presentation/widgets/loading_animation_widget.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../logic/cubit/brokers_by_area/get_area_brokers_cubit.dart';
import '../../logic/cubit/broker_changed/broker_changed_cubit.dart';
import 'bottom_card_data_holder.dart';

class ChooseBrokerScreen extends StatefulWidget {
  final ChooseBrokerArgument chooseBrokerArgument;
  const ChooseBrokerScreen({Key? key, required this.chooseBrokerArgument}) : super(key: key);

  @override
  _ChooseBrokerScreenState createState() => _ChooseBrokerScreenState();
}

class _ChooseBrokerScreenState extends State<ChooseBrokerScreen> {
  late PageController _pageController;
  late final GetAreaBrokersCubit areaBrokersCubit;
  late final BrokerChangedCubit brokerChangedCubit;

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
    areaBrokersCubit = getItInstance<GetAreaBrokersCubit>();
    areaBrokersCubit.fetchBrokers();

    /// init brokerChangedCubit
    brokerChangedCubit = getItInstance<BrokerChangedCubit>();
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
        BlocProvider<GetAreaBrokersCubit>(create: (_) => areaBrokersCubit),
        BlocProvider<BrokerChangedCubit>(create: (_) => brokerChangedCubit),
      ],
      child: Scaffold(
        /// AppBar
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Brokers"),
        ),

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocConsumer<GetAreaBrokersCubit, GetAreaBrokersState>(
            /// listener on AreaBrokersBloc
            listener: (context, state) {
              if (state is AreaBrokersFetched) {
                /// add change broker to show BottomCardDataHolder with current broker
                brokerChangedCubit.changeBroker(state.brokers[0]);
              }
            },

            /// builder of AreaBrokersBloc
            builder: (context, state) {
              /// loading
              if (state is LoadingAreaBrokers) {
                return const Center(child: LoadingAnimationWidget());
              }

              /// empty list
              if (state is NoBrokerInArea) {
                return const Center(
                  child: EmptyListWidget(text: 'No Brokers to show'),
                );
              }

              /// error
              if (state is ErrorWhileLoadingAreaBrokers) {
                return Center(
                  child: Text(
                    'Error: ${state.appError.appErrorType} , Message: ${state.appError.message}',
                  ),
                );
              }

              /// loaded
              if (state is AreaBrokersFetched) {
                final brokers = state.brokers;
                return Column(
                  children: [
                    /// PageView with brokers images
                    TopBrokersPageViewWidget(
                      brokers: brokers,
                      pageController: _pageController,
                    ),

                    /// BottomCardDataHolder
                    Container(
                      width: ScreenUtil.screenWidth * _cardWidthRatio(context),
                      height: ScreenUtil.screenHeight * 0.35,
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
}
