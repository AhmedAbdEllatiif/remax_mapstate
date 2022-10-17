import 'package:equatable/equatable.dart';

class FilterDataEntity extends Equatable{
  final List<String> cities;
  final List<String> finishingTypes;
  late final List<String> unitTypes;

  FilterDataEntity({
    required this.cities,
    required this.finishingTypes,
    required final List<String> types,
    required final List<String> layouts,
  }) {
    unitTypes = [];
    unitTypes.addAll(types);
    unitTypes.addAll(layouts);
  }


  @override
  List<Object?> get props => [cities,finishingTypes];
}
