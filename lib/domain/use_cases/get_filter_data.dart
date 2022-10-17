import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/params/filter_data_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/filter_data_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetFilterDataCase extends UseCase<FilterDataEntity, FilterDataParams> {
  final RemoteRepository apiRepo;

  GetFilterDataCase({required this.apiRepo});

  @override
  Future<Either<AppError, FilterDataEntity>> call(
          FilterDataParams params) async =>
      await apiRepo.fetchFilterData(params);
}
