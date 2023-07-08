import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/presentation/journeys/ambassador_support/ambassador_support_data.dart';
import 'package:remax_mapstate/presentation/journeys/team_support/team_support_screen.dart';
import 'package:remax_mapstate/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';

import '../../common/enums/user_types.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userType = context.read<AuthorizedUserCubit>().state.currentUserType;

    return userType == UserType.ambassador
        ? const AmbassadorSupportDataWidget()
        : const TeamSupportScreen();
  }
}
