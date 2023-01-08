import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';
import 'package:remax_mapstate/domain/use_cases/get_broker_by_id.dart';

import '../../../../common/constants/app_utils.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';

part 'get_broker_by_id_state.dart';

class GetBrokerByIdCubit extends Cubit<GetBrokerByIdState> {
  GetBrokerByIdCubit() : super(GetBrokerByIdInitial());

  /// updateDefaultUser
  void getBrokerById({
    required String brokerId,
  }) async {
    //==> convert brokerId from string to int
    final id = int.tryParse(brokerId);

    //==> check if id is null
    if (id == null) {
      _emitIfNotClosed(NotABrokerBeforeGettingBrokerById());
    }

    //==> check if id is -1
    else if (id == -1) {
      _emitIfNotClosed(NotABrokerBeforeGettingBrokerById());
    }

    //==> else start loading the user data
    else {
      //=> loading
      _emitIfNotClosed(LoadingGetBrokerById());

      // init params
      final params = id;

      // init useCase
      final useCase = getItInstance<GetBrokerByIdCase>();

      // fetch unit type names
      final either = await useCase(params);

      either.fold(
        //==> error
        (appError) => _emitError(appError),

        //==> success
        (userEntity) {
          // check user data is completed or not
          _isProfileNeedToUpdateUser(userEntity)
              //==>  user data not completed
              ? _emitIfNotClosed(
                  NotCompletedDataForBroker(userEntity: userEntity),
                )
              //==> user data is completed
              : _emitIfNotClosed(
                  BrokerDataFetched(userEntity: userEntity),
                );
        },
      );
    }
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.wrongEmailOrPassword) {
      // _emitIfNotClosed(WrongEmailOrPassword());
      /// TODO handle if user is not exists instead of wrongEmailOrPassword
    }
    if (appError.appErrorType == AppErrorType.unAuthorized) {
      _emitIfNotClosed(UnAuthorizedToGetBrokerById());
    } else {
      _emitIfNotClosed(ErrorWhileGettingBrokerById(appError: appError));
    }
  }

  /// return true if user data need to update
  bool _isProfileNeedToUpdateUser(UserEntity userEntity) {
    final phoneNum = userEntity.phoneNumber;
    final yearsOfExperience = userEntity.experienceYears;
    final favAreas = userEntity.favoriteAreas;

    // check of any of these need to update
    return phoneNum == AppUtils.undefined ||
        yearsOfExperience == -1 ||
        favAreas.isEmpty;
  }

  /// emit if not closed
  void _emitIfNotClosed(GetBrokerByIdState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
