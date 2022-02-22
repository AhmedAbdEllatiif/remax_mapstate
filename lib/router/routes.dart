import 'package:flutter/material.dart';
import 'package:remax_mapstate/presentation/journeys/area_projects/area_screen.dart';
import 'package:remax_mapstate/presentation/journeys/choose_broker/choose_broker_screen.dart';
import 'package:remax_mapstate/presentation/journeys/main/main_screen.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_details_screen.dart';
import 'package:remax_mapstate/presentation/journeys/projects/projects_screen.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/choose_user_type/choose_user_screen.dart';

import '../common/constants/route_list.dart';
import '../presentation/journeys/choose_broker/arguments/choose_broker_argument.dart';
import '../presentation/journeys/project_details/project_details_argument.dart';
import '../presentation/journeys/projects/projects_argument.dart';
import '../presentation/journeys/start_app/login/login_screen.dart';

class Routes{

  static Map<String,WidgetBuilder> getRoutes(RouteSettings settings)=>{
    RouteList.mainScreen : (context) => const MainScreen(),
    RouteList.loginScreen : (context) => const LoginScreen(),
    RouteList.chooseUserScreen : (context) => const ChooseUserScreen(),
    RouteList.projectsScreen : (context) => const ProjectsScreen(),
    RouteList.chooseBrokerScreen : (context) =>  ChooseBrokerScreen(chooseBrokerArgument: settings.arguments as ChooseBrokerArgument),
    RouteList.areaScreen : (context) =>  AreaScreen(areaArgument: settings.arguments as AreaArgument),
    RouteList.projectDetailsScreen : (context) =>  ProjectDetailsScreen( projectDetailsArgument:  settings.arguments as ProjectDetailsArgument),
  };

}