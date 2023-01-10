import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/domain/use_cases/complete_broker_data_case.dart';

import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/complete_broker_data_params.dart';

part 'complete_broker_data_state.dart';

class CompleteBrokerDataCubit extends Cubit<CompleteBrokerDataState> {
  CompleteBrokerDataCubit() : super(CompleteBrokerDataInitial());

  /// updateDefaultUser
  void completeBrokerData({
    required String brokerId,
    required String yearsOfExperience,
    required List<AreaEntity> favRegions,
  }) async {
    emit(LoadingCompleteBrokerDataInitial());

    final experienceYearsInt = int.tryParse(yearsOfExperience);
    if (experienceYearsInt == null) {
      _emitIfNotClosed(ExperienceYearsMustBeANumber());
      return;
    }

    // to convert list of areas to list of ids
    final regionsIds = _convertToListOfId(favRegions);
    if (regionsIds.isEmpty) {
      return;
    }

    // init params
    final params = CompleteBrokerDataParams(
      brokerId: int.parse(brokerId),
      favoriteRegions: regionsIds,
      experienceYears: experienceYearsInt,
    );

    // init useCase
    final useCase = getItInstance<CompleteBrokerDataCase>();

    // fetch unit type names
    final either = await useCase(params);

    either.fold(
      //==> error
      (appError) => _emitError(appError),

      //==> success
      (_) {
        _emitIfNotClosed(BrokerDataCompletedSuccessfully());
      },
    );
  }

  /// to convert list of areas to list of ids
  List<int> _convertToListOfId(List<AreaEntity> areas) {
    try {
      return areas.map((e) => int.parse(e.id)).toList();
    } on FormatException catch (e) {
      log("CompleteBrokerDataCubit >> _convertToListOfId Cannot convert areaEntity_id to int");
      _emitIfNotClosed(
        const ErrorWhileCompletingBrokerData(
          appError: AppError(AppErrorType.unHandledError),
        ),
      );
      return [];
    }
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unAuthorized) {
      _emitIfNotClosed(UnAuthorizedCompleteBrokerDataInitial());
    } else {
      _emitIfNotClosed(ErrorWhileCompletingBrokerData(appError: appError));
    }
  }

  /// emit if not closed
  void _emitIfNotClosed(CompleteBrokerDataState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
