import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/models/success_model.dart';
import 'package:remax_mapstate/data/params/open_facebook_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/repositories/app_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class LaunchFacebookCase extends UseCase<SuccessModel,OpenFaceBookParams>{

  final AppRepository appRepository;

  LaunchFacebookCase({
    required this.appRepository,
  });

  @override
  Future<Either<AppError, SuccessModel>> call(OpenFaceBookParams params) async =>
      appRepository.openFaceBook(params);

}