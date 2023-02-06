import '../../common/enums/app_language.dart';

class FetchAmbassadorParams {
  final String userToken;
  final AppLanguage appLanguage;
  final int ambassadorId;

  FetchAmbassadorParams({
    required this.userToken,
    required this.ambassadorId,
    required this.appLanguage,
  });
}
