import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/projects/projects_argument.dart';
import 'package:remax_mapstate/presentation/journeys/projects/projects_screen.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

class AreaScreen extends StatelessWidget {
  final AreaArgument areaArgument;



  const AreaScreen({Key? key,required this.areaArgument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        /// Appbar
        appBar: AppBar(
          centerTitle: true,
          title: Text(areaArgument.area.title
            //TranslateConstants.projects.t(context),
          ),
          bottom:  TabBar(
            indicatorColor: AppColor.vulcan,
            unselectedLabelColor: AppColor.fadeVulcan,
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
    );
  }
}
