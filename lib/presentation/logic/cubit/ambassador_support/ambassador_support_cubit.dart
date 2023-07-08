import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/params/get_ambassador_support_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/ambassador_support_entity.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/ambassador_support_case.dart';

part 'ambassador_support_state.dart';

class AmbassadorSupportCubit extends Cubit<AmbassadorSupportState> {
  AmbassadorSupportCubit() : super(AmbassadorSupportStateInitial());

  /// load the current developer data
  void loadAmbassadorSupportData({required String userToken}) async {
    // loading
    _emitIfNotClosed(LoadingAmbassadorSupportState());

    // init params
    final params = GetAmbassadorSupportParams(userToken: userToken);

    // init usecase
    final usecase = getItInstance<GetAmbassadorSupportCase>();

    // request
    final either = await usecase(params);

    either.fold(
      // appError
          (appError) {
        _emitIfNotClosed(ErrorWhileLoadingAmbassadorSupport(appError: appError));
      },

      // success
          (listOfAmbassadorSupportEntities) {
        listOfAmbassadorSupportEntities.isNotEmpty
            ? _emitIfNotClosed(AmbassadorSupportDataLoaded(
            ambassadorSupportEntity: listOfAmbassadorSupportEntities[0]))
            : _emitIfNotClosed(NoAmbassadorSupportFound());
      },
    );
  }

  /// emit if not closed
  void _emitIfNotClosed(AmbassadorSupportState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
