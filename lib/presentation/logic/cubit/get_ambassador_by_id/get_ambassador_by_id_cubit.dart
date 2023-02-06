import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/enums/app_language.dart';
import 'package:remax_mapstate/domain/entities/users/ambassador_entity.dart';

import '../../../../common/constants/app_utils.dart';
import '../../../../data/params/fetch_ambassador_user_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/get_ambassador_by_id.dart';

part 'get_ambassador_by_id_state.dart';

class GetAmbassadorByIdCubit extends Cubit<GetAmbassadorByIdState> {
  GetAmbassadorByIdCubit() : super(GetAmbassadorByIdInitial());

  /// getAmbassadorById
  void tryToGetAmbassadorById({
    required String ambassadorId,
    required String userToken,
    required AppLanguage appLanguage,
  }) async {
    //==> convert AmbassadorId from string to int
    final id = int.tryParse(ambassadorId);

    //==> check if id is null
    if (id == null) {
      _emitIfNotClosed(NotAAmbassadorBeforeGettingAmbassadorById());
    }

    //==> check if id is -1
    else if (id == -1) {
      _emitIfNotClosed(NotAAmbassadorBeforeGettingAmbassadorById());
    }

    //==> else start loading the user data
    else {
      //=> loading
      _emitIfNotClosed(LoadingGetAmbassadorById());

      // init params
      final params = FetchAmbassadorParams(
        ambassadorId: id,
        appLanguage: appLanguage,
        userToken: userToken,
      );

      // init useCase
      final useCase = getItInstance<GetAmbassadorByIdCase>();

      // send request
      final either = await useCase(params);

      either.fold(
        //==> error
        (appError) => _emitError(appError),

        //==> success
        (ambassadorEntity) {
          // check user data is completed or not
          _isProfileNeedToUpdateUser(ambassadorEntity)
              //==>  user data not completed
              ? _emitIfNotClosed(
                  NotCompletedDataForAmbassador(
                      ambassadorEntity: ambassadorEntity),
                )
              //==> user data is completed
              : _emitIfNotClosed(
                  AmbassadorDataFetched(ambassadorEntity: ambassadorEntity),
                );
        },
      );
    }
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.userNotFound) {
      _emitIfNotClosed(AmbassadorNotFoundById());
    }
    if (appError.appErrorType == AppErrorType.unAuthorized) {
      _emitIfNotClosed(UnAuthorizedToGetAmbassadorById());
    } else {
      _emitIfNotClosed(ErrorWhileGettingAmbassadorById(appError: appError));
    }
  }

  /// return true if user data need to update
  bool _isProfileNeedToUpdateUser(AmbassadorEntity ambassadorEntity) {
    final phoneNum = ambassadorEntity.phoneNumber;
    final jobTitle = ambassadorEntity.jobTitle;

    // check of any of these need to update
    return phoneNum == AppUtils.undefined || jobTitle == AppUtils.undefined;
    //favAreas.isEmpty;
  }

  /// emit if not closed
  void _emitIfNotClosed(GetAmbassadorByIdState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
