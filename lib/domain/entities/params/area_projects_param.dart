import 'package:equatable/equatable.dart';

class AreaProjectsParam extends Equatable{
  final int areaId;

  const AreaProjectsParam({
    required this.areaId,
  });

  @override
  List<Object?> get props => [areaId];
}