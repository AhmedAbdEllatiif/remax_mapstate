import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/models/success_model.dart';
import 'package:remax_mapstate/data/params/open_facebook_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/data/params/make_call_params.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:remax_mapstate/data/params/whatsapp_params.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/params/open_map_params.dart';

class AppRepository {
  /// To make a phoneCall
  Future<Either<AppError, SuccessModel>> openFaceBook(
      OpenFaceBookParams openFaceBookParams) async {
    try {
      // String fbProtocolUrl;
      // if (Platform.isIOS) {
      //   fbProtocolUrl = 'fb://profile/{your-page-id}';
      // } else {
      //   fbProtocolUrl = 'fb://page/{your-page-id}';
      // }

      String fallbackUrl = openFaceBookParams.url;

      try {
        Uri fbBundleUri = Uri.parse(fallbackUrl);
        var canLaunchNatively = await canLaunchUrl(fbBundleUri);

        if (canLaunchNatively) {
          launchUrl(fbBundleUri);
        } else {
          await launchUrl(Uri.parse(fallbackUrl),
              mode: LaunchMode.externalApplication);
        }
      } catch (e, st) {
        AppError(AppErrorType.canNotOpenFacebook, message: "Error: $e");
      }

      return Right(SuccessModel());
    } on Exception catch (e) {
      return Left(
        AppError(AppErrorType.canNotOpenFacebook, message: "Error: $e"),
      );
    }
  }

  /// To make a phoneCall
  Future<Either<AppError, SuccessModel>> makeAPhoneCall(
      MakeCallParams phoneCallParams) async {
    try {
      //==> init phoneNum
      final phoneNum = phoneCallParams.phoneNum;

      //==> init uri
      final Uri uri = Uri(
        scheme: 'tel',
        path: phoneNum,
      );

      //==> launch
      await launchUrl(uri);

      return Right(SuccessModel());
    } on Exception catch (e) {
      return Left(
        AppError(AppErrorType.canNotMakePhoneCall, message: "Error: $e"),
      );
    }
  }

  /// To make open whatsapp
  //https://wa.me/$phoneNum?text=I'm%20interested%20in%20your%20car%20for%20sale
  Future<Either<AppError, SuccessModel>> openWhatsapp(
      WhatsappParams params) async {
    try {
      //==> init phoneNum and message
      final phoneNum = params.num;
      final text = params.text;

      //==> init url according to current platform
      final String url = Platform.isAndroid
          ?
          // add the [https]
          "https://wa.me/$phoneNum/?text=${Uri.parse(text)}" // new line
          :
          // add the [https]
          "https://api.whatsapp.com/send?phone=$phoneNum=${Uri.parse(text)}"; // new line

      // ios platform
      if (Platform.isIOS) {
        // for iOS phone only
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(
            url,
          ));
        } else {
          return const Left(
            AppError(AppErrorType.canOpenWhatsapp,
                message: "Whatsapp not installed"),
          );
        }
      }

      // android and web
      else {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(
            Uri.parse(url),
            mode: LaunchMode.externalNonBrowserApplication,
          );
        } else {
          return const Left(
            AppError(AppErrorType.canOpenWhatsapp,
                message: "Whatsapp not installed"),
          );
        }
      }

      return Right(SuccessModel());
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
