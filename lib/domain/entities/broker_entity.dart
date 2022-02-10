import 'package:equatable/equatable.dart';

class BrokerEntity extends Equatable{

  final int id;
  final int age;
  final String image;
  final String name;
  final num rating;
  final int totalDoneDeals;
  final String whatsappNum;
  final String phoneNum;

  const BrokerEntity({
    required this.id,
    required this.age,
    required this.image,
    required this.name,
    required this.rating,
    required this.totalDoneDeals,
    required this.whatsappNum,
    required this.phoneNum,
  });


  @override
  List<Object?> get props => [id];
}