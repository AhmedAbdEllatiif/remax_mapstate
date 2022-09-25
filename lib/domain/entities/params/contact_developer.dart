import 'package:equatable/equatable.dart';

class ContactDeveloperParam extends Equatable{
  final String developerId;
  final String name;

  const ContactDeveloperParam({
    required this.developerId,
    this.name = "",
  });

  @override
  List<Object?> get props => [developerId];
}