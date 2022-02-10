import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/broker_entity.dart';

part 'broker_changed_state.dart';

class BrokerChangedCubit extends Cubit<BrokerChangedState> {



  BrokerChangedCubit() : super(BrokerChangedInitialState());


  void changeBroker(BrokerEntity brokerEntity) =>
      emit(OnBrokerChangedState(brokerEntity: brokerEntity));

}
