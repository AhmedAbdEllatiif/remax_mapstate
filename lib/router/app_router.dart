import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/argument_constants.dart';
import 'package:remax_mapstate/presentation/journeys/main/main_screen.dart';
import 'package:remax_mapstate/presentation/journeys/projects/projects_argument.dart';
import 'package:remax_mapstate/presentation/journeys/projects/projects_screen.dart';



class AppRouter{
  static const String mainScreen = "/";
  static const String loginScreen = "/login";
  static const String homeScreen = "/home";
  static const String chooseUserScreen = "/chooseUser";
  static const String notificationScreen = "/notifications";
  static const String projectScreen = "/projectScreen";




  Route? onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {

    /// Main Screen \\\
      case mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());

    /// Projects Screen \\\
      case projectScreen:
        return MaterialPageRoute(builder: (context){
          final args = routeSettings.arguments as Map<String,ProjectsArgument>;
          final projectsArgument = args[ArgumentConstants.projectsArgument] as ProjectsArgument;
          return  ProjectsScreen(projectsArgument: projectsArgument,);
        });

    /// Choose User Screen \\\
      //case chooseUserScreen:
        //return MaterialPageRoute(builder: (_) => const ChooseUserScreen());

    /// login Screen \\\
      //case loginScreen:
        //return MaterialPageRoute(builder: (_) => const LoginScreen());

    /// notification Screen \\\
      //case notificationScreen:
        //return MaterialPageRoute(builder: (_) => const NotificationScreen());

      default:
        return null;
    }
  }

}