import 'package:flutter/material.dart';
import 'package:remax_mapstate/domain/entities/broker_entity.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';
import 'package:remax_mapstate/presentation/journeys/choose_broker/brokers_page_view/broker_text_name.dart';
import 'package:remax_mapstate/presentation/journeys/choose_broker/brokers_page_view/brokers_view_page.dart';
import 'package:remax_mapstate/presentation/widgets/separator.dart';

class TopBrokersPageViewWidget extends StatelessWidget {

  final List<UserEntity> brokers;
  final PageController pageController;
  const TopBrokersPageViewWidget({Key? key, required this.brokers, required this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        BrokersViewPage(brokers: brokers, pageController: pageController),

        const BrokerTextName(),

        // separator
        const Separator(),

      ],
    );
  }
}
