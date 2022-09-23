import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/contact_developer.dart';
import 'package:remax_mapstate/domain/entities/params/contact_developer.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetDeveloperContactCase
    extends UseCase<ContactDeveloperEntity, ContactDeveloperParam> {
  final RemoteRepository apiRepo;

  GetDeveloperContactCase({
    required this.apiRepo,
  });

  @override
  Future<Either<AppError, ContactDeveloperEntity>> call(
          ContactDeveloperParam params) async =>
      apiRepo.getDeveloperContact(params.developerId);
}
