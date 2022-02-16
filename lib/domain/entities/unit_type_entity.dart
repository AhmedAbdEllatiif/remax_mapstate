import 'package:equatable/equatable.dart';

class UnitTypeEntity extends Equatable{

  final int id;
  final String name;

  const UnitTypeEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id];
}