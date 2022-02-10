import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/broker_entity.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/repositories/api_projects.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetAreaBrokersCase extends UseCase<List<BrokerEntity>, NoParams> {
  final ApiRepo apiRepo;

  GetAreaBrokersCase({
    required this.apiRepo,
  });

  @override
  Future<Either<AppError, List<BrokerEntity>>> call(NoParams params) async =>
      await apiRepo.getAreaBrokers();
}
