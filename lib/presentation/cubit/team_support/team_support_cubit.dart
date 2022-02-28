import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/entities/team_support_entity.dart';

import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/phone_call.dart';
import '../../../domain/entities/params/whatsapp_params.dart';
import '../../../domain/use_cases/get_team_support.dart';
import '../../../domain/use_cases/make_phone_call.dart';
import '../../../domain/use_cases/open_whats_app.dart';

part 'team_support_state.dart';

class TeamSupportCubit extends Cubit<TeamSupportState> {
  final GetTeamSupportCase getTeamSupportCase;
  final OpenWhatsappCase openWhatsappCase;
  final MakePhoneCallCase makePhoneCallCase;

  TeamSupportCubit({
    required this.getTeamSupportCase,
    required this.openWhatsappCase,
    required this.makePhoneCallCase,
  }) : super(LoadingTeamSupportState());

  /// load the current developer data
  void loadTeamSupportData() async {
    /// loading
    _emitIfNotClosed(LoadingTeamSupportState());

    Future.delayed(const Duration(seconds: 3), () async {
      final eitherData = await getTeamSupportCase(NoParams());
      eitherData.fold(
        (appError) {
          /// appError
          _emitIfNotClosed(TeamSupportErrorState(appError: appError));
        },
        (teamSupportData) {
          /// with TeamSupportDataLoaded
          _emitIfNotClosed(
              TeamSupportDataLoaded(teamSupportEntity: teamSupportData));
        },
      );
    });
  }

  /// To open whats app
  void openWhatsApp({required String welcomeText, required String text}) {
    if (state.teamSupportEntity != null) {
      final whatsappNum = state.teamSupportEntity!.phoneNum;
      final empName = state.teamSupportEntity!.name;
      openWhatsappCase(WhatsappParams(
          num: whatsappNum, text: "$welcomeText $empName $text"));
    }
  }

  /// To make a phone call
  void makePhoneCall() {
    if (state.teamSupportEntity != null) {
      final phoneNum = state.teamSupportEntity!.phoneNum;
      makePhoneCallCase(PhoneNumParams(phoneNum: phoneNum));
    }
  }

  /// emit if not closed
  void _emitIfNotClosed(TeamSupportState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
