import 'package:flutter/material.dart';
import 'package:remax_mapstate/domain/entities/params/contact_developer.dart';
import 'package:remax_mapstate/presentation/arguments/project_by_status_args.dart';
import 'package:remax_mapstate/presentation/journeys/all_areas/all_areas_screen.dart';
import 'package:remax_mapstate/presentation/journeys/area_unit_types/area_unit_types_screen.dart';
import 'package:remax_mapstate/presentation/journeys/calculation_result/calculation_result_screen.dart';
import 'package:remax_mapstate/presentation/journeys/choose_broker/choose_broker_screen.dart';
import 'package:remax_mapstate/presentation/journeys/developer_contact/developer_contact_screen.dart';
import 'package:remax_mapstate/presentation/journeys/main/main_screen.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_details_screen.dart';
import 'package:remax_mapstate/presentation/journeys/projects_by_status/projects_by_status_screen.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/broker_registartion/broker_registartion_screen.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/choose_user_type/choose_user_screen.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/spotter_registration/spotter_registration_screen.dart';

import '../common/constants/route_list.dart';
import '../presentation/journeys/choose_broker/arguments/choose_broker_argument.dart';
import '../presentation/arguments/project_details_argument.dart';
import '../presentation/arguments/area_unit_types_args.dart';
import '../presentation/journeys/start_app/client_registration/client_login_or_registration_screen.dart';
import '../presentation/logic/bloc/calculator_validation/calculator_validation_bloc.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) => {
        /// MainScreen
        RouteList.mainScreen: (context) => const MainScreen(),

        /// ChooseUserScreen
        RouteList.chooseUserScreen: (context) => const ChooseUserScreen(),

        /// ClientLoginOrRegistrationScreen
        RouteList.clientRegistration: (context) =>
            const ClientLoginOrRegistrationScreen(),

        /// SpotterRegistrationScreen
        RouteList.spotterRegistration: (context) =>
            const SpotterRegistrationScreen(),

        /// BrokerRegistrationScreen
        RouteList.brokerRegistration: (context) =>
            const BrokerRegistrationScreen(),

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

        /// projectByStatus
        RouteList.projectByStatus: (context) => ProjectsByStatusScreen(
              projectByStatusArguments:
                  settings.arguments as ProjectByStatusArguments,
            ),
      };
}
