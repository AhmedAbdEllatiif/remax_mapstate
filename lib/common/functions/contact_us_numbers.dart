import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import '../enums/user_types.dart';

String getContactNumber({required BuildContext context}) {
  final userType = context.read<AuthorizedUserCubit>().state.currentUserType;
  switch (userType) {
    case UserType.broker:
      return "01018819992";

    case UserType.ambassador:
      return "01028836218";

    case UserType.client:
    case UserType.tour:
    case UserType.unDefined:
      return "01154949495";
  }
}

/*brokers—— 01018819992
ambassadors ——- 01028836218
buyers——— 01154949495*/
