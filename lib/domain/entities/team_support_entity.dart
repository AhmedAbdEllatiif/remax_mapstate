import 'package:equatable/equatable.dart';


class TeamSupportEntity extends Equatable {
  final int id;
  final String name;
  final String phoneNum;
  final String whatsappNum;
  final String image;

  const TeamSupportEntity({
   required this.id,
   required this.name ,
   required this.phoneNum,
   required this.whatsappNum,
   required this.image,
  });


  @override
  List<Object?> get props => [id];
}
