import 'package:remax_mapstate/domain/entities/users/user_entity.dart';
import 'package:remax_mapstate/presentation/logic/cubit/complete_broker_data/complete_broker_data_cubit.dart';

class CompleteBrokerDataArguments {
  final UserEntity userEntity;
  final CompleteBrokerDataCubit completeBrokerDataCubit;

  CompleteBrokerDataArguments({
    required this.userEntity,
    required this.completeBrokerDataCubit,
  });
}
