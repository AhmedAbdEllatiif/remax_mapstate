import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/params/get_ambassador_support_params.dart';
import 'package:remax_mapstate/domain/entities/ambassador_support_entity.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetAmbassadorSupportCase
    extends UseCase<List<AmbassadorSupportEntity>, GetAmbassadorSupportParams> {
  final RemoteRepository remoteRepository;

  GetAmbassadorSupportCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, List<AmbassadorSupportEntity>>> call(
          GetAmbassadorSupportParams params) async =>
      await remoteRepository.getAmbassadorSupport(params);
}
