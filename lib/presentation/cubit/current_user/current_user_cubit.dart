import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/data/tables/current_user_table.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/current_user.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/current_user/get_current_user.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/current_user/update_current_user.dart';

import '../../../domain/entities/params/no_params.dart';

part 'current_user_state.dart';

class CurrentUserCubit extends Cubit<CurrentUserTable> {
  final GetCurrentUserCase getCurrentUserCase;
  final UpdateCurrentUserCase updateCurrentUserCase;

  CurrentUserCubit({
    required this.getCurrentUserCase,
    required this.updateCurrentUserCase,
  }) : super(CurrentUserTable.fromCurrentUserEntity(
             CurrentUserEntity(currentUserStr: UserType.noUser.toShortString())));

  /// to update currentUser
  Future<void> changeUser(CurrentUserEntity currentUserEntity) async {
    final currentUser =
        CurrentUserTable.fromCurrentUserEntity(currentUserEntity);
    await updateCurrentUserCase(currentUser);
    loadCurrentUser();
  }

  /// to load currentUser
  void loadCurrentUser() async {
    final response = await getCurrentUserCase(NoParams());
    emit(response.fold(
      (l) => CurrentUserTable.fromCurrentUserEntity( CurrentUserEntity(currentUserStr: UserType.noUser.toShortString())),
      (currentUser) => currentUser,
    ));
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
