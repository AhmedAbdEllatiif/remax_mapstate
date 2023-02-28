import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/data/params/get_team_support_params.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/entities/team_support_entity.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../data/params/make_call_params.dart';
import '../../../../data/params/whatsapp_params.dart';
import '../../../../domain/use_cases/get_team_support.dart';
import '../../../../domain/use_cases/make_phone_call.dart';
import '../../../../domain/use_cases/open_whats_app.dart';

part 'team_support_state.dart';

class TeamSupportCubit extends Cubit<TeamSupportState> {
  TeamSupportCubit() : super(TeamSupportStateInitial());

  /// load the current developer data
  void loadTeamSupportData({required String userToken}) async {
    // loading
    _emitIfNotClosed(LoadingTeamSupportState());

    // init params
    final params = GetTeamSupportParams(userToken: userToken);

    // init usecase
    final usecase = getItInstance<GetTeamSupportCase>();

    // request
    final either = await usecase(params);

    either.fold(
      // appError
      (appError) {
        _emitIfNotClosed(ErrorWhileLoadingTeamSupport(appError: appError));
      },

      // success
      (listOfTeamSupportEntities) {
        listOfTeamSupportEntities.isNotEmpty
            ? _emitIfNotClosed(TeamSupportDataLoaded(
                teamSupportEntity: listOfTeamSupportEntities[0]))
            : _emitIfNotClosed(NoTeamSupportFound());
      },
    );
  }

  /// emit if not closed
  void _emitIfNotClosed(TeamSupportState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
