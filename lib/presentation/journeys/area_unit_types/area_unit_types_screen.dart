import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/arguments/area_unit_types_args.dart';
import 'package:remax_mapstate/presentation/journeys/area_unit_types/tab_pages/commercial_page.dart';

import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/city_background_widget.dart';

import '../../../common/constants/sizes.dart';
import 'tab_pages/residentail_page.dart';

class AreaUnitTypesScreen extends StatelessWidget {
  final AreaUnitTypesArguments areaArgument;

  const AreaUnitTypesScreen({Key? key, required this.areaArgument})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const CityBackgroundWidget(),
        DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.transparent,

            /// Appbar
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text(areaArgument.area.name
                  //TranslateConstants.projects.t(context),
                  ),

              //==> tabs
              bottom: TabBar(
                indicatorColor: AppColor.geeBung,
                labelColor: AppColor.geeBung,
                unselectedLabelColor: AppColor.white,
                tabs: [
                  Tab(
                    text: TranslateConstants.residential.t(context),
                    icon: const Icon(Icons.home_outlined),
                  ),
                  Tab(
                    text: TranslateConstants.commercial.t(context),
                    icon: const Icon(Icons.apartment),
                  ),
                  //Tab(text: "Done",icon: Icon(Icons.done_all)),
                ],
              ),
            ),

            /// body
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
              child: TabBarView(
                children: [
                  ResidentialUnitTypesPage(
                    cityName: areaArgument.area.name,
                  ),
                  CommercialUnitTypesPage(
                    cityName: areaArgument.area.name,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
