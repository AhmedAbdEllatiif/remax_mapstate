import 'package:equatable/equatable.dart';

class AreaEntity extends Equatable{

  final int id;
  final String title;

  const AreaEntity({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id];


}