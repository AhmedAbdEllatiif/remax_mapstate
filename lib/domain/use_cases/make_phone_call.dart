import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/phone_call.dart';
import 'package:remax_mapstate/domain/repositories/app_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class MakePhoneCallCase extends UseCase<void,PhoneNumParams>{

  final AppRepository appRepository;

   MakePhoneCallCase({
    required this.appRepository,
  });

  @override
  Future<Either<AppError, void>> call(PhoneNumParams params) async =>
      appRepository.makeAPhoneCall(params);

}