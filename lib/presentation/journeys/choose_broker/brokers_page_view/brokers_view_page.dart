import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/domain/entities/broker_entity.dart';
import 'package:remax_mapstate/presentation/cubit/broker_changed/broker_changed_cubit.dart';

import '../broker_animated_card.dart';

class BrokersViewPage extends StatelessWidget {

  final List<BrokerEntity> brokers;
  final PageController pageController;

  const BrokersViewPage({Key? key, required this.brokers, required this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
      height: ScreenUtil.screenHeight * 0.35,
      child: PageView.builder(
        pageSnapping: true,
        controller: pageController,
        itemCount: brokers.length,
        itemBuilder: (context, index) {
          final broker = brokers[index];
          return BrokerAnimatedCard(
            imagePath: broker.image,
            index: index,
            pageController: pageController,
          );
        },
        onPageChanged: (index) {
          BlocProvider.of<BrokerChangedCubit>(context)
              .changeBroker(brokers[index]);
        },
      ),
    );
  }
}
