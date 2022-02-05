import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';


// Type ==> What does the useCase return
// Param ==> What is required to call API
abstract class UseCase<Type,Params>{

  Future<Either<AppError,Type>> call(Params params);
}