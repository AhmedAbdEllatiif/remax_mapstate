import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/models/success_model.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/contact_us_request_params.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class ContactUsCase extends UseCase<SuccessModel, ContactUsRequestParams> {
  final RemoteRepository remoteRepository;

  ContactUsCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, SuccessModel>> call(
          ContactUsRequestParams params) async =>
      await remoteRepository.contactUs(params);
}
