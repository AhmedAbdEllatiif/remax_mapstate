import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';

part 'choose_favorite_area_state.dart';

class ChooseFavoriteAreaCubit extends Cubit<ChooseFavoriteAreaState> {
  ChooseFavoriteAreaCubit()
      : super(const ChooseFavoriteAreaState(selectedAreas: [], length: 0));

  void _emitIfNotClosed(ChooseFavoriteAreaState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  void changeSelected(List<AreaEntity> selectedAreas) {
    final length = selectedAreas.length;
    _emitIfNotClosed(
      ChooseFavoriteAreaState(selectedAreas: selectedAreas, length: length),
    );
  }

  void removeSelected(Object removedArea) {
    state.selectedAreas.remove(removedArea);
    final length = state.selectedAreas.length;
    _emitIfNotClosed(
      ChooseFavoriteAreaState(selectedAreas: state.selectedAreas, length: length),
    );
  }
}
