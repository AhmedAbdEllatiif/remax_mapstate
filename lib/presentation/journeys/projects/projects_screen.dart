import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/projects/projects_argument.dart';
import 'package:remax_mapstate/presentation/journeys/projects/tab_pages/commercial_page.dart';
import 'package:remax_mapstate/presentation/journeys/projects/tab_pages/residentail_page.dart';


class ProjectsScreen extends StatelessWidget {


  const ProjectsScreen({Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
      child: const TabBarView(
        children: [
          ResidentialPage(),
          CommercialPage(),
        ],
      ),
    );
  }
}
