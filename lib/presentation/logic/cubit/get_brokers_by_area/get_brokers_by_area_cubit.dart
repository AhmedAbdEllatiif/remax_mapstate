import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/enums/app_language.dart';
import 'package:remax_mapstate/data/models/filter_model.dart';
import 'package:remax_mapstate/data/params/get_brokers_by_area_params.dart';
import 'package:remax_mapstate/domain/use_cases/get_broker_by_region_case.dart';

import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/user_entity.dart';

part 'get_brokers_by_area_state.dart';

class GetBrokersByAreaCubit extends Cubit<GetBrokersByAreaState> {
  GetBrokersByAreaCubit() : super(GetBrokersByAreaInitial());

  void tryToGetBrokersByArea({
    required String userToken,
    required String regionName,
    required AppLanguage appLanguage,
  }) async {
    // loading
    _emitIfNotClosed(LoadingToGeBrokersByArea());

    // init filters
    final filterField = appLanguage == AppLanguage.en
        ? "favorite_regions__name"
        : "favorite_regions__arabic_name";
    final FilterModel filterModel =
        FilterModel(field: filterField, value: regionName);

    // init params
    final params = GetBrokersByAreaParams(
      userToken: userToken,
      filters: [filterModel],
    );

    // init usecase
    final GetBrokersByRegionCase usecase =
        getItInstance<GetBrokersByRegionCase>();

    // send request
    final either = await usecase(params);

    either.fold(
      //==> error
      (appError) => _emitIfNotClosed(
        ErrorWhileGettingBrokersByArea(appError: appError),
      ),

      //==> success
      (brokersList) {
        if (brokersList.isEmpty) {
          _emitIfNotClosed(EmptyListOfBrokersInThisArea());
        } else {
          _emitIfNotClosed(BrokersOfAreaFetched(brokersList: brokersList));
        }
      },
    );
  }

  /// emit if not closed
  void _emitIfNotClosed(GetBrokersByAreaState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
