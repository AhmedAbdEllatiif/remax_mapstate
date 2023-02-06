import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/data/params/update_ambassador_data_params.dart';
import 'package:remax_mapstate/domain/use_cases/update_ambassador_data_case.dart';

import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';

part 'update_ambassador_data_state.dart';

class UpdateAmbassadorDataCubit extends Cubit<UpdateAmbassadorDataState> {
  UpdateAmbassadorDataCubit() : super(UpdateAmbassadorDataInitial());

  /// to update current user fav projects
  void tryToUpdateAmbassadorData({
    required String userId,
    required String userToken,
    required String currentJobTitle,
  }) async {
    emit(LoadingUpdateAmbassadorData());

    // init params
    final params = UpdateAmbassadorDataParams(
      ambassadorId: int.tryParse(userId) ?? -1,
      userToken: userToken,
      currentJobTitle: currentJobTitle,
    );

    // init useCase
    final useCase = getItInstance<UpdateAmbassadorDataCase>();

    // fetch unit type names
    final either = await useCase(params);

    either.fold(
      //==> error
      (appError) => _emitError(appError),

      //==> success
      (_) {
        _emitIfNotClosed(AmbassadorDataUpdatedSuccessfully());
      },
    );
  }

  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unAuthorized) {
      _emitIfNotClosed(UnAuthorizedUpdateAmbassadorData());
    } else {
      _emitIfNotClosed(ErrorWhileUpdatingAmbassadorData(appError: appError));
    }
  }

  /// emit if not closed
  void _emitIfNotClosed(UpdateAmbassadorDataState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
