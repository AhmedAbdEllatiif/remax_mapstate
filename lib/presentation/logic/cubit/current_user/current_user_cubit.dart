import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/current_user/get_current_user.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/current_user/update_current_user.dart';

import '../../../../domain/entities/params/no_params.dart';

part 'current_user_state.dart';

class CurrentUserCubit extends Cubit<UserEntity> {
  final GetCurrentUserCase getCurrentUserCase;
  final UpdateCurrentUserCase updateCurrentUserCase;

  CurrentUserCubit({
    required this.getCurrentUserCase,
    required this.updateCurrentUserCase,
  }) : super(UserEntity.empty());

  /// to remove currentUser
  Future<void> removeUser() async {
    await updateCurrentUserCase(UserEntity.empty());
    loadCurrentUser();
  }

  /// to update currentUser
  Future<void> changeUser(UserEntity currentUserEntity) async {
    await updateCurrentUserCase(currentUserEntity);
    loadCurrentUser();
  }

  /// to load currentUser
  Future<UserType> getCurrentUserType() async {
    final response = await getCurrentUserCase(NoParams());
    final currentUser = response.fold(
      (error) => UserEntity.empty(),
      (currentUser) => currentUser,
    );
    return currentUser.userType;
  }

  /// to load currentUser
  void loadCurrentUser() async {
    final response = await getCurrentUserCase(NoParams());

    if (!isClosed) {
      emit(response.fold(
        (l) => UserEntity.empty(),
        (currentUser) => currentUser,
      ));
    }
  }

/*// tour
  void tourUser() => emit(const CurrentUserState(userType: UserType.tour));

  // client
  void clientUser() => emit(const CurrentUserState(userType: UserType.client));

  // broker
  void brokerUser() => emit(const CurrentUserState(userType: UserType.broker));

  // other
  void otherUser() => emit(const CurrentUserState(userType: UserType.other));*/
}
