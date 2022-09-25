import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/projects/projects_argument.dart';
import 'package:remax_mapstate/presentation/journeys/projects/projects_screen.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/city_background_widget.dart';

class AreaUnitTypesScreen extends StatelessWidget {
  final AreaArgument areaArgument;



  const AreaUnitTypesScreen({Key? key,required this.areaArgument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const CityBackgroundWidget(),
        DefaultTabController(
          length: 2,
          child: Scaffold(
            /// Appbar
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text(areaArgument.area.name
                //TranslateConstants.projects.t(context),
              ),
              bottom:  TabBar(
                indicatorColor: AppColor.geeBung,
                labelColor: AppColor.geeBung,
                unselectedLabelColor: AppColor.absoluteTransparentGeeBung,
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
            body: ProjectsScreen(),
          ),
        ),
      ],
    );
  }
}
