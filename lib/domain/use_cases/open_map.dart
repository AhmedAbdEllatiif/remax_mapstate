import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/map_entity.dart';
import 'package:remax_mapstate/domain/repositories/app_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class OpenMapCase extends UseCase<void,MapEntity>{

  final AppRepository appRepository;

  OpenMapCase({
    required this.appRepository,
  });

  @override
  Future<Either<AppError, void>> call(MapEntity params) async =>
      appRepository.openMap(params);

}