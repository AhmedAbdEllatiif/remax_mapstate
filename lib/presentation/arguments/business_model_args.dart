import 'package:remax_mapstate/common/enums/user_types.dart';

class BusinessModelArguments {
  final UserType userType;
  final bool withAppBar;
  final bool withButton;

  BusinessModelArguments({
    required this.userType,
    this.withAppBar = false,
    this.withButton = true,
  });
}
