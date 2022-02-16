import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/argument_constants.dart';
import 'package:remax_mapstate/presentation/journeys/area_projects/area_screen.dart';
import 'package:remax_mapstate/presentation/journeys/projects/projects_argument.dart';
import 'package:remax_mapstate/presentation/journeys/projects/projects_screen.dart';
import 'package:remax_mapstate/presentation/journeys/choose_broker/choose_broker_screen.dart';
import 'package:remax_mapstate/presentation/journeys/main/main_screen.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_details_argument.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_details_screen.dart';


class AppRouter {
  static const String mainScreen = "/";
  static const String loginScreen = "/login";
  static const String homeScreen = "/home";
  static const String chooseUserScreen = "/chooseUser";
  static const String notificationScreen = "/notifications";
  static const String projectsScreen = "/projectsScreen";
  static const String projectDetailsScreen = "/projectDetailsScreen";
  static const String chooseBrokerScreen = "/chooseBrokerScreen";
  static const String areaScreen = "/areaScreen";

  Route? onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {

      /// Main Screen \\\
      case mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      /// Projects Screen \\\
      case projectsScreen:
        return MaterialPageRoute(builder: (context) {
          return const ProjectsScreen();
        });

    /// Area Screen \\\
      case areaScreen:
        return MaterialPageRoute(builder: (context) {
          final args = routeSettings.arguments as Map<String, AreaArgument>;
          final areaArgument =
          args[ArgumentConstants.areaArgument] as AreaArgument;
          return AreaScreen(
            areaArgument: areaArgument,
          );
        });

      /// ProjectDetails Screen \\\
      case projectDetailsScreen:
        return MaterialPageRoute(builder: (context) {
          final args =
              routeSettings.arguments as Map<String, ProjectDetailsArgument>;
          final projectDetails =
              args[ArgumentConstants.projectDetails] as ProjectDetailsArgument;
          return ProjectDetailsScreen(projectDetailsArgument: projectDetails);
        });

      /// Choose Broker Screen \\\
      case chooseBrokerScreen:
      return MaterialPageRoute(builder: (_) => const ChooseBrokerScreen());

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
