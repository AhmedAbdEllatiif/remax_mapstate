import 'package:flutter/cupertino.dart';
import 'package:remax_mapstate/common/constants/route_list.dart';
import 'package:remax_mapstate/domain/entities/arguments/register_or_login_args.dart';
import 'package:remax_mapstate/domain/entities/params/contact_developer.dart';
import 'package:remax_mapstate/presentation/arguments/advanced_filter_result_args.dart';
import 'package:remax_mapstate/presentation/arguments/project_by_status_args.dart';
import 'package:remax_mapstate/presentation/arguments/project_details_argument.dart';
import 'package:remax_mapstate/presentation/arguments/area_unit_types_args.dart';
import '../presentation/journeys/choose_broker/arguments/choose_broker_argument.dart';
import '../presentation/logic/bloc/calculator_validation/calculator_validation_bloc.dart';

class RouteHelper {
  RouteHelper();

  /// To MainScreen \\\
  void mainScreen(
    BuildContext context, {
    required isClearStack,
  }) {
    isClearStack
        ? Navigator.pushNamedAndRemoveUntil(
            context, RouteList.mainScreen, (routePredicate) => false)
        : Navigator.of(context).pushNamed(RouteList.mainScreen);
  }

  /// To LoginScreen \\\
  void loginScreen(BuildContext context) => Navigator.of(context).pushNamed(
        RouteList.loginScreen,
      );

  /// To ChooseUserTypeScreen \\\
  void chooseUserTypeScreen(
    BuildContext context, {
    required isClearStack,
  }) {
    isClearStack
        ? Navigator.pushNamedAndRemoveUntil(
            context, RouteList.chooseUserScreen, (routePredicate) => false)
        : Navigator.of(context).pushNamed(RouteList.chooseUserScreen);
  }

  /// To ProjectDetailScreen \\\
  void projectDetailScreen(BuildContext context,
          {required ProjectDetailsArgument projectDetailsArgument}) =>
      Navigator.of(context).pushNamed(
        RouteList.projectDetailsScreen,
        arguments: projectDetailsArgument,
      );

  /// To AreaScreen \\\
  void areaScreen(BuildContext context,
          {required AreaUnitTypesArguments areaArgument}) =>
      Navigator.of(context)
          .pushNamed(RouteList.areaScreen, arguments: areaArgument);

  /// To BrokersScreen \\\
  void chooseBrokerScreen(BuildContext context,
          {required ChooseBrokerArgument chooseBrokerArgument}) =>
      Navigator.of(context).pushNamed(RouteList.chooseBrokerScreen,
          arguments: chooseBrokerArgument);

  /// To ContactDeveloperScreen \\\
  void contactDeveloper(BuildContext context,
          {required ContactDeveloperParam contactDeveloperParam}) =>
      Navigator.of(context).pushNamed(RouteList.developerContact,
          arguments: contactDeveloperParam);

  /// To CalculationResultScreen \\\
  void calculationResultScreen(BuildContext context,
          CalculatorValidationBloc calculatorValidationBloc) =>
      Navigator.of(context).pushNamed(RouteList.calculationResult,
          arguments: calculatorValidationBloc);

  /// To ClientRegistrationScreen \\\
  void clientRegistrationScreen(BuildContext context) =>
      Navigator.of(context).pushNamed(RouteList.clientRegistration);

  /// To SpotterRegistrationScreen \\\
  void spotterRegistrationScreen(BuildContext context) =>
      Navigator.of(context).pushNamed(RouteList.spotterRegistration);

  /// To BrokerRegistrationScreen \\\
  void registerOrLoginScreen(
    BuildContext context, {
    required RegisterOrLoginArguments registerOrLoginArguments,
    bool removeAllScreens = false,
  }) {
    if (removeAllScreens) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        RouteList.brokerRegistration,
        (route) => false,
        arguments: registerOrLoginArguments,
      );
    } else {
      Navigator.of(context).pushNamed(
        RouteList.brokerRegistration,
        arguments: registerOrLoginArguments,
      );
    }
  }

  /// To BrokerRegistrationScreen \\\
  void filterProjectsScreen(BuildContext context) =>
      Navigator.of(context).pushNamed(RouteList.filterProjects);

  /// To AllAreas screen \\\
  void allAreasScreen(BuildContext context) =>
      Navigator.of(context).pushNamed(RouteList.allAreas);

  /// To ProjectByStatusArguments \\\
  void projectsByStatus(BuildContext context,
          {required ProjectByStatusArguments projectByStatusArguments}) =>
      Navigator.of(context).pushNamed(RouteList.projectByStatus,
          arguments: projectByStatusArguments);

  /// To AreasByStatusScreen \\\
  void areasByStatusScreen(BuildContext context,
          {required ProjectByStatusArguments projectByStatusArguments}) =>
      Navigator.of(context).pushNamed(RouteList.areasByStatusScreen,
          arguments: projectByStatusArguments);

  /// To AdvancedFilterResultScreen \\\
  void advancedFilterResultScreen(BuildContext context,
          {required AdvancedFilterResultArgs advancedFilterResultArgs}) =>
      Navigator.of(context).pushNamed(RouteList.advancedFilterResult,
          arguments: advancedFilterResultArgs);
}
//Navigator.pushNamed(context, AppRouter.chooseBrokerScreen)
