import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String name;
  final String path;

  const ServiceEntity({
    required this.name,
    required this.path,
  });

  @override
  List<Object?> get props => [name, path];
}
