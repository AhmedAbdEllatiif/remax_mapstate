import 'package:remax_mapstate/domain/entities/users/ambassador_entity.dart';

import '../logic/cubit/update_ambassador_date/update_ambassador_data_cubit.dart';

class UpdateAmbassadorArguments {
  final AmbassadorEntity ambassadorEntity;
  final UpdateAmbassadorDataCubit completeAmbassadorDataCubit;

  UpdateAmbassadorArguments({
    required this.ambassadorEntity,
    required this.completeAmbassadorDataCubit,
  });
}
