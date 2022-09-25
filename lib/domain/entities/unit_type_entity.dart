import 'package:equatable/equatable.dart';

class UnitTypeEntity extends Equatable {
  final String id;
  final String name;
  final bool isCommercial;
  final int priority;

  const UnitTypeEntity({
    required this.id,
    required this.name,
    required this.isCommercial,
    required this.priority,
  });

  @override
  List<Object?> get props => [id];
}
