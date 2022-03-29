part of 'choose_favorite_area_cubit.dart';

class ChooseFavoriteAreaState extends Equatable {
  final List<AreaEntity> selectedAreas;
  final int length;

  const ChooseFavoriteAreaState({
    required this.selectedAreas,
    required this.length,
  });

  @override
  List<Object> get props => [selectedAreas,length];
}




