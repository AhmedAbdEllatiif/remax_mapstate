import 'package:flutter/cupertino.dart';
import 'package:remax_mapstate/common/constants/route_list.dart';
import 'package:remax_mapstate/domain/entities/params/contact_developer.dart';
import 'package:remax_mapstate/presentation/bloc/calculator_validation/calculator_validation_bloc.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_details_argument.dart';
import 'package:remax_mapstate/presentation/journeys/projects/projects_argument.dart';
import '../presentation/journeys/choose_broker/arguments/choose_broker_argument.dart';

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
  void areaScreen(BuildContext context, {required AreaArgument areaArgument}) =>
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
  void calculationResultScreen(BuildContext context,CalculatorValidationBloc calculatorValidationBloc) =>
      Navigator.of(context).pushNamed(RouteList.calculationResult,arguments: calculatorValidationBloc );

  /// To ClientRegistrationScreen \\\
  void clientRegistrationScreen(BuildContext context) =>
      Navigator.of(context).pushReplacementNamed(RouteList.clientRegistration);

  /// To SpotterRegistrationScreen \\\
  void spotterRegistrationScreen(BuildContext context) =>
      Navigator.of(context).pushReplacementNamed(RouteList.spotterRegistration);

  /// To BrokerRegistrationScreen \\\
  void brokerRegistrationScreen(BuildContext context) =>
      Navigator.of(context).pushReplacementNamed(RouteList.brokerRegistration);
}
//Navigator.pushNamed(context, AppRouter.chooseBrokerScreen)
