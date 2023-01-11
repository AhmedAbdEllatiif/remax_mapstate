import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/reigster_params.dart';
import 'package:remax_mapstate/domain/entities/register_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class RegisterNewUserCase extends UseCase<RegisterEntity, RegisterParams> {
  final RemoteRepository remoteRepository;

  RegisterNewUserCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, RegisterEntity>> call(RegisterParams params) async =>
      await remoteRepository.registerNewUser(params);
}
