import 'package:remax_mapstate/domain/entities/unit_type_entity.dart';

class UnitTypeModel extends UnitTypeEntity{
  final int id;
  final String name;

  const UnitTypeModel({
    required this.id,
    required this.name,
  }):super(id: id,name:name );

  @override
  List<Object?> get props => [id];
}