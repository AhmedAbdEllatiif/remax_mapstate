import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/first_launch/get_first_launch_case.dart';

import '../../../../domain/use_cases/local_usecases/first_launch/change_first_launch_case.dart';

part 'first_launch_state.dart';

class FirstLaunchStatusCubit extends Cubit<bool> {
  FirstLaunchStatusCubit() : super(true);

  Future<void> changeFirstLaunchStatus() async {
    final useCase = getItInstance<ChangeFirstLaunchCase>();
   await useCase(NoParams());
  }

  void loadFirstLaunchStatus() async {
    final useCase = getItInstance<GetFirstLaunchCase>();
    final either = await useCase(NoParams());
    either.fold(
      (error) => _emitIfNotClosed(true),
      (status) => _emitIfNotClosed(status),
    );
  }

  /// emit if not closed
  void _emitIfNotClosed(bool state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
