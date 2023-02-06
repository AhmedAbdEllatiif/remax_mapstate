import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/data/params/fetch_broker_params.dart';
import 'package:remax_mapstate/domain/entities/users/user_entity.dart';
import 'package:remax_mapstate/domain/use_cases/get_broker_by_id.dart';

import '../../../../common/constants/app_utils.dart';
import '../../../../common/enums/app_language.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../language/language_cubit.dart';

part 'get_broker_by_id_state.dart';

class GetBrokerByIdCubit extends Cubit<GetBrokerByIdState> {
  GetBrokerByIdCubit() : super(GetBrokerByIdInitial());

  /// updateDefaultUser
  void getBrokerById(
    BuildContext context, {
    required String brokerId,
  }) async {
    // init current language
    final languageCode = context.read<LanguageCubit>().state.languageCode;
    final appLanguage = languageCode == "en" ? AppLanguage.en : AppLanguage.ar;

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
      final params = FetchBrokerParams(
        brokerId: id,
        appLanguage: appLanguage,
      );

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
    return
      phoneNum == AppUtils.undefined ||
       // yearsOfExperience == -1 ||
        favAreas.isEmpty;
  }

  /// emit if not closed
  void _emitIfNotClosed(GetBrokerByIdState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
