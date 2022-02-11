import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/projects/tab_pages/commercial_page.dart';
import 'package:remax_mapstate/presentation/journeys/projects/projects_argument.dart';
import 'package:remax_mapstate/presentation/journeys/projects/tab_pages/residentail_page.dart';

class ProjectsScreen extends StatelessWidget {
  final ProjectsArgument projectsArgument;

  const ProjectsScreen({Key? key, required this.projectsArgument})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        /// Appbar
        appBar: AppBar(
          centerTitle: true,
          title: Text(projectsArgument.area.title
              //TranslateConstants.projects.t(context),
              ),
          bottom:  TabBar(
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
          child: const TabBarView(
            children: [
               ResidentialPage(),
               CommercialPage(),
            ],
          ),
        ),
      ),
    );
  }
}
