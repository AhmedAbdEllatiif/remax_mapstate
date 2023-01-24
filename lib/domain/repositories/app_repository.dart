import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/models/success_model.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/map_entity.dart';
import 'package:remax_mapstate/data/params/make_call_params.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:remax_mapstate/data/params/whatsapp_params.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/params/open_map_params.dart';

class AppRepository {
  /// To make a phoneCall
  Future<Either<AppError, void>> makeAPhoneCall(
      MakeCallParams phoneCallParams) async {
    // launch(urlString)
    final phoneNum = phoneCallParams.phoneNum;
    try {
      return Right(await launch('tel:$phoneNum'));
    } on Exception catch (e) {
      return Left(
          AppError(AppErrorType.canNotMakePhoneCall, message: "Error: $e"));
    }
  }

  /// To make open whatsapp
  Future<Either<AppError, void>> openWhatsapp(WhatsappParams params) async {
    // launch(urlString)
    final phoneNum = params.num;
    final text = params.text;
    //https://wa.me/$phoneNum?text=I'm%20interested%20in%20your%20car%20for%20sale
    try {
      return Right(await launch('https://wa.me/$phoneNum?text=$text'));
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.canOpenWhatsapp, message: "Error: $e"));
    }
  }

  /// To open the map
  Future<Either<AppError, SuccessModel>> openMap({
    required OpenMapParams openMapParams,
  }) async {
    try {
      final availableMaps = await MapLauncher.installedMaps;
      log('AvailableMaps:  $availableMaps');

      await availableMaps.first.showMarker(
        coords: Coords(openMapParams.latitude, openMapParams.longitude),
        title: openMapParams.locationName,
      );
      return Right(SuccessModel());
    } on Exception catch (e) {
      return Left(
        AppError(AppErrorType.errorWhileOpenMap, message: "Error: $e"),
      );
    }
  }
}
