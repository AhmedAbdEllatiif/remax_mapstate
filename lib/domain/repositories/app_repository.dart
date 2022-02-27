import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/map_entity.dart';
import 'package:remax_mapstate/domain/entities/params/phone_call.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:remax_mapstate/domain/entities/params/whatsapp_params.dart';
import 'package:url_launcher/url_launcher.dart';

class AppRepository{

  /// To make a phoneCall
  Future<Either<AppError,void>> makeAPhoneCall(PhoneNumParams phoneCallParams) async {
     // launch(urlString)
    final phoneNum = phoneCallParams.phoneNum;
    try{
      return Right(await launch('tel:$phoneNum'));
    }on Exception catch(e){
      return Left(AppError(AppErrorType.canNotMakePhoneCall,message: "Error: $e"));
    }
  }


  /// To make open whatsapp
  Future<Either<AppError,void>> openWhatsapp(WhatsappParams params) async {
    // launch(urlString)
    final phoneNum = params.num;
    final text = params.text;
    //https://wa.me/$phoneNum?text=I'm%20interested%20in%20your%20car%20for%20sale
    try{
      return Right(await launch('https://wa.me/$phoneNum?text=$text'));
    }on Exception catch(e){
      return Left(AppError(AppErrorType.canOpenWhatsapp,message: "Error: $e"));
    }
  }



  /// To open the map
  Future<Either<AppError,void>> openMap(MapEntity mapParams) async {

    final availableMaps = await MapLauncher.installedMaps;
    print('AvailableMaps:  $availableMaps');

    // launch(urlString)
    final latitude = mapParams.latitude;
    final longitude = mapParams.longitude;
    final markerTitle = mapParams.markerTitle;
    //https://wa.me/$phoneNum?text=I'm%20interested%20in%20your%20car%20for%20sale
    try{
      return Right(await availableMaps.first.showMarker(
        coords: Coords(37.759392, -122.5107336),
        title: "Ocean Beach",
      ));
    }on Exception catch(e){
      return Left(AppError(AppErrorType.canOpenWhatsapp,message: "Error: $e"));
    }
  }

}