import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/bloc/brokers_by_area/area_brokers_bloc.dart';
import 'package:remax_mapstate/presentation/cubit/broker_changed/broker_changed_cubit.dart';
import 'package:remax_mapstate/presentation/journeys/choose_broker/broker_data_widget.dart';
import 'package:remax_mapstate/presentation/journeys/choose_broker/brokers_page_view/top_broker_page_view_widget.dart';
import 'package:remax_mapstate/presentation/journeys/choose_broker/contact_info_card.dart';
import 'package:remax_mapstate/presentation/widgets/empty_list_widegt.dart';
import 'package:remax_mapstate/presentation/widgets/loading_animation_widget.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class ChooseBrokerScreen extends StatefulWidget {
  const ChooseBrokerScreen({Key? key}) : super(key: key);

  @override
  _ChooseBrokerScreenState createState() => _ChooseBrokerScreenState();
}

class _ChooseBrokerScreenState extends State<ChooseBrokerScreen> {
  late PageController _pageController;
  late final AreaBrokersBloc areaBrokersBloc;
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
    areaBrokersBloc = getItInstance<AreaBrokersBloc>();
    areaBrokersBloc.add(LoadAreaBrokersEvent());

    /// init brokerChangedCubit
    brokerChangedCubit = getItInstance<BrokerChangedCubit>();
  }

  @override
  void dispose() {
    areaBrokersBloc.close();
    brokerChangedCubit.close();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AreaBrokersBloc>(create: (_) => areaBrokersBloc),
        BlocProvider<BrokerChangedCubit>(create: (_) => brokerChangedCubit),
      ],
      child: Scaffold(

        /// AppBar
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Brokers"),
        ),




        body: BlocConsumer<AreaBrokersBloc, AreaBrokersState>(
          listener: (context, state) {
            if (state is AreaBrokersLoadedState) {
              brokerChangedCubit.changeBroker(state.brokers[0]);
            }
          },
          builder: (context, state) {


            /// loading
            if (state is AreaBrokersLoadingState) {
              return const Center(child: LoadingAnimationWidget());
            }


            /// empty list
            if (state is NoBrokerInArea) {
              return const Center(
                  child: EmptyListWidget(
                text: 'No Brokers to show',
              ));
            }

            /// error
            if (state is AreaBrokersErrorState) {
              return Center(
                  child: Text(
                'Error: ${state.appError.appErrorType} , Message: ${state.appError.message}',
              ));
            }

            /// loaded
            if (state is AreaBrokersLoadedState) {
              final brokers = state.brokers;
              return Column(
                children: [
                  TopBrokersPageViewWidget(
                    brokers: brokers,
                    pageController: _pageController,
                  ),



                  BlocBuilder<BrokerChangedCubit, BrokerChangedState>(
                      builder: (context, state) {
                    if (state is OnBrokerChangedState) {
                      final currentBroker = state.brokerEntity;

                      return Container(
                        width: ScreenUtil.screenWidth *
                            ResponsiveValue<double>(context,
                                defaultValue: 0.7,
                                valueWhen: const [
                                  Condition.equals(name: TABLET, value: 0.5),
                                  Condition.largerThan(
                                      name: TABLET, value: 0.5),
                                  Condition.equals(name: MOBILE, value: 0.7),
                                  Condition.smallerThan(
                                      name: MOBILE, value: 0.7),
                                ]).value!,
                        height: ScreenUtil.screenHeight * 0.35,
                        margin: EdgeInsets.only(top: Sizes.dimen_20.w),
                        child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.white70, width: 1),
                            borderRadius:
                                BorderRadius.circular(Sizes.dimen_16.w),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              /// rating
                              BrokerDataWidget(
                                dataKey: "Rating",
                                value: currentBroker.rating.toDouble(),
                                isRating: true,
                              ),

                              /// name
                              BrokerDataWidget(
                                dataKey: "Name",
                                value: currentBroker.name,
                              ),

                              /// age
                              BrokerDataWidget(
                                dataKey: "Age",
                                value: currentBroker.age.toString(),
                              ),

                              /// deals
                              BrokerDataWidget(
                                dataKey: "Done Deals",
                                value: currentBroker.totalDoneDeals.toString(),
                              ),

                              const SizedBox(
                                height: 30,
                              ),

                              /// contact info
                              ContactInfoCard(
                                phoneNum: currentBroker.whatsappNum,
                                whatsapp: currentBroker.phoneNum,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const Center(child: SizedBox.shrink());
                  })
                ],
              );
            }

            /// nothing to show
            return const Center(child: SizedBox.shrink());
          },
        ),
      ),
    );

  }
}
