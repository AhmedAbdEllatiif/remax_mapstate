import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/login_entity.dart';
import 'package:remax_mapstate/domain/entities/params/login_params.dart';
import 'package:remax_mapstate/domain/use_cases/login.dart';

import '../../../../di/git_it.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  /// updateDefaultUser
  void tryToLogin({
    required String email,
    required String password,
  }) async {
    emit(LoadingLogin());

    // init params
    final params = LoginParams(
      email: email,
      password: password,
    );

    // init useCase
    final useCase = getItInstance<LoginCase>();

    // fetch unit type names
    final either = await useCase(params);

    either.fold(
      //==> error
      (appError) => _emitError(appError),

      //==> success
      (loginEntity) {
        _emitIfNotClosed(LoginSuccess(
          loginEntity: loginEntity,
        ));
      },
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.wrongEmailOrPassword) {
      _emitIfNotClosed(WrongEmailOrPassword());
    } else {
      _emitIfNotClosed(ErrorWhileLogin(appError: appError));
    }
  }

  /// emit if not closed
  void _emitIfNotClosed(LoginState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
