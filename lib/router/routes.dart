import 'package:flutter/material.dart';
import 'package:remax_mapstate/domain/entities/params/contact_developer.dart';
import 'package:remax_mapstate/presentation/journeys/all_areas/all_areas_screen.dart';
import 'package:remax_mapstate/presentation/journeys/area_unit_types/area_unit_types_screen.dart';
import 'package:remax_mapstate/presentation/journeys/calculation_result/calculation_result_screen.dart';
import 'package:remax_mapstate/presentation/journeys/choose_broker/choose_broker_screen.dart';
import 'package:remax_mapstate/presentation/journeys/developer_contact/developer_contact_screen.dart';
import 'package:remax_mapstate/presentation/journeys/main/main_screen.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_details_screen.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/broker_registartion/broker_registartion_screen.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/choose_user_type/choose_user_screen.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/spotter_registration/spotter_registration_screen.dart';

import '../common/constants/route_list.dart';
import '../presentation/journeys/choose_broker/arguments/choose_broker_argument.dart';
import '../presentation/journeys/project_details/project_details_argument.dart';
import '../presentation/arguments/area_unit_types_args.dart';
import '../presentation/journeys/start_app/client_registration/client_login_or_registration_screen.dart';
import '../presentation/logic/bloc/calculator_validation/calculator_validation_bloc.dart';

class Routes{

  static Map<String,WidgetBuilder> getRoutes(RouteSettings settings)=>{
    RouteList.mainScreen : (context) => const MainScreen(),
    RouteList.chooseUserScreen : (context) => const ChooseUserScreen(),
    RouteList.clientRegistration : (context) => const ClientLoginOrRegistrationScreen(),
    RouteList.spotterRegistration : (context) => const SpotterRegistrationScreen(),
    RouteList.brokerRegistration : (context) => const BrokerRegistrationScreen(),
    RouteList.calculationResult : (context) =>  CalculationResultScreen(calculatorValidationBloc: settings.arguments as CalculatorValidationBloc),
    RouteList.developerContact : (context) => DeveloperContactScreen(developerContactParams:  settings.arguments as ContactDeveloperParam),
    RouteList.chooseBrokerScreen : (context) =>  ChooseBrokerScreen(chooseBrokerArgument: settings.arguments as ChooseBrokerArgument),
    RouteList.areaScreen : (context) =>  AreaUnitTypesScreen(areaArgument: settings.arguments as AreaUnitTypesArguments),
    RouteList.projectDetailsScreen : (context) =>  ProjectDetailsScreen( projectDetailsArgument:  settings.arguments as ProjectDetailsArgument),
    RouteList.allAreas : (context) => const AllAreasScreen(),
  };

}