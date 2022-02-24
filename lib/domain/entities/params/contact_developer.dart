import 'package:equatable/equatable.dart';

class ContactDeveloperParam extends Equatable{
  final int developerId;
  final String name;

  const ContactDeveloperParam({
    required this.developerId,
    this.name = "",
  });

  @override
  List<Object?> get props => [developerId];
}