import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/update_user_params.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';
import 'package:remax_mapstate/domain/use_cases/update_default_user.dart';

part 'update_default_user_state.dart';

class UpdateDefaultUserCubit extends Cubit<UpdateDefaultUserState> {
  UpdateDefaultUserCubit() : super(UpdateDefaultUserInitial());

  /// loadUnitTypes
  void loadUnitTypes({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    emit(LoadingToUpdateDefaultUser());

    // init params
    final params = UpdateDefaultUserParams(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );

    // init useCase
    final useCase = getItInstance<UpdateDefaultUserCase>();

    // fetch unit type names
    final either = await useCase(params);

    either.fold(
      //==> error
      (appError) => _emitError(appError),

      //==> success
      (userEntity) => _emitIfNotClosed(SuccessUpdateDefaultUser(
        userEntity: userEntity,
      )),
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.emailAlreadyExists) {
      _emitIfNotClosed(UpdateDefaultUserEmailAlreadyExists());
    } else if (appError.appErrorType == AppErrorType.passwordIsMissing) {
      _emitIfNotClosed(UpdateDefaultUserPasswordIsMissing());
    } else {
      _emitIfNotClosed(ErrorWhileUpdatingDefaultUser(appError: appError));
    }
  }

  /// emit if not closed
  void _emitIfNotClosed(UpdateDefaultUserState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
