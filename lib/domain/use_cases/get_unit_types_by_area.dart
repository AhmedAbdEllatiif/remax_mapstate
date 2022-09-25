import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/params/fetch_unit_type_names.dart';
import 'package:remax_mapstate/data/params/fetch_unit_type_names.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/entities/unit_type_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetUnitTypeNamesCase
    extends UseCase<List<UnitTypeEntity>, FetchUnitTypeNamesParams> {
  final RemoteRepository apiRepo;

  GetUnitTypeNamesCase({
    required this.apiRepo,
  });

  @override
  Future<Either<AppError, List<UnitTypeEntity>>> call(
          FetchUnitTypeNamesParams params) =>
      apiRepo.fetchUnitTypeNames(params);
}
