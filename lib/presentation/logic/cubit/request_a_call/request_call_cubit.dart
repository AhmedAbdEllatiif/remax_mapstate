import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/data/params/request_a_call_params.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/use_cases/request_a_call_case.dart';

import '../../../../domain/entities/app_error.dart';

part 'request_call_state.dart';

class RequestCallCubit extends Cubit<RequestCallState> {
  RequestCallCubit() : super(RequestCallInitial());

  void tryRequestCall({
    required String userToken,
    required String userId,
    required String projectId,
  }) async {
    // loading
    _emitIfNotClosed(LoadingRequestCall());

    // init params
    final params = RequestACallParams(
      userToken: userToken,
      userId: userId,
      projectId: projectId,
      subject: "subject",
      body: "body",
    );

    // init usecase
    final RequestCallCase usecase = getItInstance<RequestCallCase>();

    // send request
    final either = await usecase(params);

    either.fold(
      //==> error
      (appError) => _emitIfNotClosed(
        _errorStateToEmit(appError),
      ),

      //==> success
      (success) => _emitIfNotClosed(RequestCallSuccessfullySent()),
    );
  }

  /// to return state according to app error
  RequestCallState _errorStateToEmit(AppError appError) {
    final appErrorType = appError.appErrorType;

    //==> already call request on this prohject
    if (appErrorType == AppErrorType.mustBeUnique) {
      return AlreadyRequestOnThisProject();
    }

    //==> UnAuthenticated
    else if (appErrorType == AppErrorType.unAuthorized) {
      return UnAuthenticatedToRequestCall();
    }

    //==> else
    return ErrorWhileRequestingCall(appError: appError);
  }

  /// emit if not closed
  void _emitIfNotClosed(RequestCallState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
