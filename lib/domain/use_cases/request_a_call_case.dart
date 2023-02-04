import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/models/success_model.dart';
import 'package:remax_mapstate/data/params/request_a_call_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class RequestCallCase extends UseCase<SuccessModel, RequestACallParams> {
  final RemoteRepository remoteRepository;

  RequestCallCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, SuccessModel>> call(
          RequestACallParams params) async =>
      await remoteRepository.requestCall(params);
}
