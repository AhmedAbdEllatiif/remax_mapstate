import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../common/enums/user_types.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/authorized_user_entity.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/use_cases/local_usecases/authorized_user/authorized_user_data/delete_user_data.dart';
import '../../../../domain/use_cases/local_usecases/authorized_user/authorized_user_data/get_user_data.dart';
import '../../../../domain/use_cases/local_usecases/authorized_user/authorized_user_data/save_user_data.dart';

part 'authorized_user_state.dart';

class AuthorizedUserCubit extends Cubit<AuthorizedUserState> {
  final SaveUserDataCase saveUserDataCase;
  final GetUserDataCase getUserDataCase;
  final DeleteUserDataCase deleteUserDataCase;

  AuthorizedUserCubit({
    required this.saveUserDataCase,
    required this.getUserDataCase,
    required this.deleteUserDataCase,
  }) : super(
          UnDefinedAuthorizedUserData(),
        );

  /// save current authorized user data
  Future<void> save(AuthorizedUserEntity userEntity) async {
    await saveUserDataCase(userEntity);
    await loadCurrentAuthorizedUserData();
  }

  /// delete current authorized user data
  Future<void> delete() async {
    await deleteUserDataCase(NoParams());
    await loadCurrentAuthorizedUserData();
  }

  /// save current authorized user data
  Future<void> loadCurrentAuthorizedUserData() async {
    final either = await getUserDataCase(NoParams());
    either.fold(
        //==> error
        (appError) => _emitIfNotClosed(
            CurrentAuthorizedUserDataError(appError: appError)),

        //==> success
        (userEntity) {
      switch (userEntity.userType) {
        case UserType.tour:
          _emitIfNotClosed(
            UnDefinedAuthorizedUserData(),
          );
          break;
        case UserType.client:
          _emitIfNotClosed(
            CurrentBuyerAuthorizedUserData(userEntity: userEntity),
          );
          break;
        case UserType.broker:
          _emitIfNotClosed(
            CurrentBrokerAuthorizedUserData(userEntity: userEntity),
          );
          break;
        case UserType.ambassador:
          _emitIfNotClosed(
            CurrentAmbassadorAuthorizedUserData(userEntity: userEntity),
          );
          break;
        case UserType.unDefined:
          _emitIfNotClosed(
            UnDefinedAuthorizedUserData(),
          );
          break;
      }
    });
  }

  /// emit if not closed
  void _emitIfNotClosed(AuthorizedUserState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
