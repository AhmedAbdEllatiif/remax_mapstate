import 'package:equatable/equatable.dart';

class WhatsappParams extends Equatable{

  final String num;
  final String text;


  const WhatsappParams({
    required this.num,
    required this.text,
  });


  @override
  List<Object?> get props => [num];

}