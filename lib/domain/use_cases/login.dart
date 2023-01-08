import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/login_entity.dart';
import 'package:remax_mapstate/domain/entities/params/login_params.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class LoginCase extends UseCase<LoginEntity, LoginParams> {
  final RemoteRepository apiRepo;

  LoginCase({
    required this.apiRepo,
  });

  @override
  Future<Either<AppError, LoginEntity>> call(LoginParams params) async =>
      await apiRepo.loginUser(params);
}
