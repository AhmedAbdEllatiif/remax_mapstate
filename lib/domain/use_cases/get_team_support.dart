import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/params/get_team_support_params.dart';
import 'package:remax_mapstate/data/params/get_team_support_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/entities/team_support_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetTeamSupportCase
    extends UseCase<List<TeamSupportEntity>, GetTeamSupportParams> {
  final RemoteRepository apiRepo;

  GetTeamSupportCase({
    required this.apiRepo,
  });

  @override
  Future<Either<AppError, List<TeamSupportEntity>>> call(
          GetTeamSupportParams params) async =>
      await apiRepo.getTeamSupport(params);
}
