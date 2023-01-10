import '../../common/enums/app_language.dart';

class FetchBrokerParams {
  final AppLanguage appLanguage;
  final int brokerId;

  FetchBrokerParams({
    required this.brokerId,
    required this.appLanguage,
  });
}
