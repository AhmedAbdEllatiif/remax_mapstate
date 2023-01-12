import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/data/params/get_profile_params.dart';
import 'package:remax_mapstate/domain/entities/profile_entity.dart';
import 'package:remax_mapstate/domain/use_cases/auth/get_current_user_profile.dart';

import '../../../../../di/git_it.dart';
import '../../../../../domain/entities/app_error.dart';

part 'get_current_user_profile_state.dart';

class GetCurrentUserProfileCubit extends Cubit<GetCurrentUserProfileState> {
  GetCurrentUserProfileCubit() : super(GetProfileInitial());

  /// getCurrentUserProfile
  void getCurrentUserProfile({
    required String userToken,
  }) async {
    emit(LoadingToGetProfile());

    // init params
    final params = GetCurrentUserProfileParams(userToken: userToken);

    // init useCase
    final useCase = getItInstance<GetCurrentUserProfileCase>();

    // fetch unit type names
    final either = await useCase(params);

    either.fold(
      //==> error
      (appError) => _emitError(appError),

      //==> success
      (profileEntity) {
        _emitIfNotClosed(ProfileDataFetchedSuccessfully(
          profileEntity: profileEntity,
        ));
      },
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unAuthorized) {
      _emitIfNotClosed(UnAuthorizedToGetProfile());
    } else {
      _emitIfNotClosed(ErrorWhileFetchingProfile(appError: appError));
    }
  }

  /// emit if not closed
  void _emitIfNotClosed(GetCurrentUserProfileState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
