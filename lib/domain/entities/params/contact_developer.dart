import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';

class ContactDeveloperParam extends Equatable {
  final DeveloperEntity developerEntity;

  const ContactDeveloperParam({
    required this.developerEntity,
  });

  @override
  List<Object?> get props => [developerEntity];
}
