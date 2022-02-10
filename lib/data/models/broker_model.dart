import 'package:remax_mapstate/domain/entities/broker_entity.dart';

class BrokerModel extends BrokerEntity {
  final int id;
  final int age;
  final String image;
  final String name;
  final num rating;
  final int totalDoneDeals;
  final String whatsappNum;
  final String phoneNum;

  const BrokerModel({
    required this.id,
    required this.age,
    required this.image,
    required this.name,
    required this.rating,
    required this.totalDoneDeals,
    required this.whatsappNum,
    required this.phoneNum,
  }) : super(
          id: id,
          age: age,
          image: image,
          name: name,
          rating: rating,
          totalDoneDeals: totalDoneDeals,
          phoneNum: phoneNum,
          whatsappNum: whatsappNum,
        );
}
