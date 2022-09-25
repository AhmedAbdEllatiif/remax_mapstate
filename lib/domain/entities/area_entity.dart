import 'package:equatable/equatable.dart';

class AreaEntity extends Equatable {
  final String id;
  final String name;
  final int priority;

  const AreaEntity({
    required this.id,
    required this.name,
    required this.priority,
  });

  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return "id:$id,\nName: $name,\nPriority: $priority";
  }
}
