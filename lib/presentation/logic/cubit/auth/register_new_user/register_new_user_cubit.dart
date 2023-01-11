import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/register_entity.dart';
import 'package:remax_mapstate/domain/use_cases/auth/register_new_user.dart';

import '../../../../../di/git_it.dart';
import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/entities/params/reigster_params.dart';

part 'register_new_user_state.dart';

class RegisterNewUserCubit extends Cubit<RegisterNewUserState> {
  RegisterNewUserCubit() : super(RegisterInitial());

  /// register
  void register({
    required String email,
    required String password,
  }) async {
    emit(LoadingToRegister());

    // init params
    final params = RegisterParams(email: email, password: password);

    // init useCase
    final useCase = getItInstance<RegisterNewUserCase>();

    // fetch unit type names
    final either = await useCase(params);

    either.fold(
      //==> error
      (appError) => _emitError(appError),

      //==> success
      (registerEntity) {
        _emitIfNotClosed(SuccessRegister(
          registerEntity: registerEntity,
        ));
      },
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.emailAlreadyExists) {
      _emitIfNotClosed(RegisterEmailAlreadyExists());
    } else if (appError.appErrorType == AppErrorType.passwordIsMissing) {
      _emitIfNotClosed(RegisterPasswordIsMissing());
    } else {
      _emitIfNotClosed(ErrorWhileRegister(appError: appError));
    }
  }

  /// emit if not closed
  void _emitIfNotClosed(RegisterNewUserState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
