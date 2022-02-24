import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/enums/login_status.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/auto_login_entity.dart';

import '../../../domain/entities/params/no_params.dart';
import '../../../domain/use_cases/local_usecases/auto_login/delete_auto_login.dart';
import '../../../domain/use_cases/local_usecases/auto_login/get_auto_login.dart';
import '../../../domain/use_cases/local_usecases/auto_login/save_auto_login.dart';

part 'auto_login_state.dart';

class AutoLoginCubit extends Cubit<AutoLoginState> {
  final GetAutoLogin getAutoLogin;
  final SaveAutoLogin saveAutoLogin;
  final DeleteAutoLogin deleteAutoLogin;

  AutoLoginCubit({
    required this.getAutoLogin,
    required this.saveAutoLogin,
    required this.deleteAutoLogin,
  }) : super(
            const CurrentAutoLoginStatus(loginStatus: LoginStatus.notLoggedIn));


  void _emitIfNotClosed(AutoLoginState state){
    if(!isClosed){
      emit(state);
    }
  }


  Future<void> save() async {
    await saveAutoLogin(AutoLoginEntity(
        currentLoginStatusStr: LoginStatus.loggedIn.toShortString()));
    await loadCurrentAutoLoginStatus();
  }

  Future<void> delete() async {
    await deleteAutoLogin(NoParams());
    await loadCurrentAutoLoginStatus();
  }

  Future<void> loadCurrentAutoLoginStatus() async {
    final either = await getAutoLogin(NoParams());
    either.fold(
      (appError) => _emitIfNotClosed(AutoLoginError(appError: appError)),
      (loginStatus) => _emitIfNotClosed(CurrentAutoLoginStatus(loginStatus: loginStatus)),
    );
  }
}
