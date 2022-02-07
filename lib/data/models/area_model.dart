import 'package:remax_mapstate/domain/entities/area_entity.dart';

class AreaModel extends AreaEntity{

  final int id;
  final String title;

  const AreaModel({
    required this.id,
    required this.title,
  }) : super(id: id, title: title);
}