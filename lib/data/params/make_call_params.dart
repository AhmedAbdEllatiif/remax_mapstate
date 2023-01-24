import 'package:equatable/equatable.dart';

class MakeCallParams extends Equatable{

  final String phoneNum;

  const MakeCallParams({
    required this.phoneNum,
  });

  @override
  List<Object?> get props => [phoneNum];

}
