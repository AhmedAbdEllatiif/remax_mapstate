import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/broker_entity.dart';

import '../../../../data/params/make_call_params.dart';
import '../../../../data/params/whatsapp_params.dart';
import '../../../../domain/use_cases/make_phone_call.dart';
import '../../../../domain/use_cases/open_whats_app.dart';

part 'broker_changed_state.dart';

class BrokerChangedCubit extends Cubit<BrokerChangedState> {
  final OpenWhatsappCase openWhatsappCase;
  final MakePhoneCallCase makePhoneCallCase;

  BrokerChangedCubit({
    required this.openWhatsappCase,
    required this.makePhoneCallCase,
  }) : super(BrokerChangedInitialState());



  /// change current broker
  void changeBroker(BrokerEntity brokerEntity) =>
      _emitIfNotClosed(OnBrokerChangedState(brokerEntity: brokerEntity));

  /// To open whats app
  void openWhatsApp({required String welcomeText, required String text}) {
    if (state.brokerEntity != null) {
      final whatsappNum = state.brokerEntity!.whatsappNum;
      final empName = state.brokerEntity!.name;
      openWhatsappCase(WhatsappParams(
          num: whatsappNum,
          text:
          "$welcomeText $empName $text"));
    }
  }

  /// To make a phone call
  void makePhoneCall() {
    if (state.brokerEntity != null) {
      final phoneNum = state.brokerEntity!.phoneNum;
      makePhoneCallCase(
          MakeCallParams(phoneNum: phoneNum));
    }
  }


  /// emit if not closed
  void _emitIfNotClosed(BrokerChangedState state) {
    if (!isClosed) {
      emit(state);
    }
  }


}
