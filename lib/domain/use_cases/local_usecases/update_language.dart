import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/repositories/app_settings_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class UpdateLanguage extends UseCase<void, String> {

  final AppSettingsRepository appSettingsRepository;


  UpdateLanguage({
    required this.appSettingsRepository,
  });


  @override
  Future<Either<AppError, void>> call(String params) async =>
      appSettingsRepository.updateLanguage(params);


}