import 'package:flutter/material.dart';
import 'package:remax_mapstate/domain/entities/arguments/complete_broker_data_arguments.dart';
import 'package:remax_mapstate/domain/entities/arguments/register_or_login_args.dart';
import 'package:remax_mapstate/domain/entities/params/contact_developer.dart';
import 'package:remax_mapstate/presentation/arguments/advanced_filter_result_args.dart';
import 'package:remax_mapstate/presentation/arguments/project_by_status_args.dart';
import 'package:remax_mapstate/presentation/journeys/advanced_filter_result/advanced_filter_result_screen.dart';
import 'package:remax_mapstate/presentation/journeys/all_areas/all_areas_screen.dart';
import 'package:remax_mapstate/presentation/journeys/area_unit_types/area_unit_types_screen.dart';
import 'package:remax_mapstate/presentation/journeys/calculation_result/calculation_result_screen.dart';
import 'package:remax_mapstate/presentation/journeys/choose_broker/choose_broker_screen.dart';
import 'package:remax_mapstate/presentation/journeys/complete_broker_data/complete_broker_data_screen.dart';
import 'package:remax_mapstate/presentation/journeys/contact_us/contact_us_screen.dart';
import 'package:remax_mapstate/presentation/journeys/developer_contact/developer_contact_screen.dart';
import 'package:remax_mapstate/presentation/journeys/filter_projects/advanced_filter_projects_screen.dart';
import 'package:remax_mapstate/presentation/journeys/main/main_screen.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_details_screen.dart';
import 'package:remax_mapstate/presentation/journeys/projects_by_status/projects_by_status_screen.dart';
import 'package:remax_mapstate/presentation/journeys/choose_user_type/choose_user_screen.dart';

import '../common/constants/route_list.dart';
import '../presentation/journeys/choose_broker/arguments/choose_broker_argument.dart';
import '../presentation/arguments/project_details_argument.dart';
import '../presentation/arguments/area_unit_types_args.dart';
import '../presentation/journeys/login_and_registration/login_or_registration_screen.dart';
import '../presentation/journeys/projects_by_status/areas_by_status/areas_by_status_screen.dart';
import '../presentation/logic/bloc/calculator_validation/calculator_validation_bloc.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) => {
        /// MainScreen
        RouteList.mainScreen: (context) => const MainScreen(),

        /// ChooseUserScreen
        RouteList.chooseUserScreen: (context) => const ChooseUserScreen(),

        /// BrokerRegistrationScreen
        RouteList.brokerRegistration: (context) => RegisterOrLoginScreen(
              registerOrLoginArguments:
                  settings.arguments as RegisterOrLoginArguments,
            ),

        /// CalculationResultScreen
        RouteList.calculationResult: (context) => CalculationResultScreen(
            calculatorValidationBloc:
                settings.arguments as CalculatorValidationBloc),

        /// DeveloperContactScreen
        RouteList.developerContact: (context) => DeveloperContactScreen(
            developerContactParams:
                settings.arguments as ContactDeveloperParam),

        /// ChooseBrokerScreen
        RouteList.chooseBrokerScreen: (context) => ChooseBrokerScreen(
            chooseBrokerArgument: settings.arguments as ChooseBrokerArgument),

        /// AreaUnitTypesScreen
        RouteList.areaScreen: (context) => AreaUnitTypesScreen(
            areaArgument: settings.arguments as AreaUnitTypesArguments),

        /// projectDetailsScreen
        RouteList.projectDetailsScreen: (context) => ProjectDetailsScreen(
            projectDetailsArgument:
                settings.arguments as ProjectDetailsArgument),

        /// allAreas
        RouteList.allAreas: (context) => const AllAreasScreen(),

        /// filterProjects
        RouteList.filterProjects: (context) =>
            const AdvancedFilterProjectsScreen(),

        /// projectByStatus
        RouteList.projectByStatus: (context) => ProjectsByStatusScreen(
              projectByStatusArguments:
                  settings.arguments as ProjectByStatusArguments,
            ),

        /// AreasByStatusScreen
        RouteList.areasByStatusScreen: (context) => AreasByStatusScreen(
              projectByStatusArguments:
                  settings.arguments as ProjectByStatusArguments,
            ),

        /// projectByStatus
        RouteList.advancedFilterResult: (context) => AdvancedFilterResultScreen(
              arguments: settings.arguments as AdvancedFilterResultArgs,
            ),

        /// completeBrokerData
        RouteList.completeBrokerData: (context) => CompleteBrokerDataScreen(
              completeBrokerDataArguments:
                  settings.arguments as CompleteBrokerDataArguments,
            ),

        /// contactUs
        RouteList.contactUs: (context) => const ContactUsScreen(),
      };
}
