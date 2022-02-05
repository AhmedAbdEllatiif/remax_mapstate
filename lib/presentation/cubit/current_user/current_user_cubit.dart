import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';

part 'current_user_state.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  CurrentUserCubit() : super(  const CurrentUserState(userType: UserType.tour));

  // tour
  void tourUser() => emit(const CurrentUserState(userType: UserType.tour));
  // client
  void clientUser() => emit(const CurrentUserState(userType: UserType.client));
  // broker
  void brokerUser() => emit(const CurrentUserState(userType: UserType.broker));
  // other
  void otherUser() => emit(const CurrentUserState(userType: UserType.other));
}
