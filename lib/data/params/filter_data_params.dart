import 'package:remax_mapstate/common/enums/app_language.dart';

class FilterDataParams {
  final AppLanguage appLanguage;
  final String userToken;

  FilterDataParams({required this.appLanguage, required this.userToken});
}
