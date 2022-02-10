import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/domain/entities/broker_entity.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';

abstract class ApiRepo {

  /// return list of TopProjects
  Future<Either<AppError,List<ProjectEntity>>> getTopProject();

  /// return list of areas
  Future<Either<AppError,List<AreaEntity>>> getAreas();



  /// return list of FavoriteProjects
  Future<Either<AppError,List<ProjectEntity>>> getFavoriteProject();


  /// return list of broker according to specefic area
  Future<Either<AppError,List<BrokerEntity>>> getAreaBrokers();


}