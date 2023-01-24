import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/data/params/make_call_params.dart';
import 'package:remax_mapstate/domain/repositories/app_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

import '../../data/params/whatsapp_params.dart';

class OpenWhatsappCase extends UseCase<void,WhatsappParams>{

  final AppRepository appRepository;

  OpenWhatsappCase({
    required this.appRepository,
  });

  @override
  Future<Either<AppError, void>> call(WhatsappParams params) async =>
      appRepository.openWhatsapp(params);

}