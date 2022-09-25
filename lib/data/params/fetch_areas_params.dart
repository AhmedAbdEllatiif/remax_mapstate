import 'package:remax_mapstate/common/enums/app_language.dart';

class FetchAreaParams {
  final AppLanguage appLanguage;
  final int limit;
  final int offset;
  final String orderBy;

  FetchAreaParams({
    this.limit = 50,
    this.offset = 0,
    this.orderBy = "",
    required this.appLanguage,
  });
}
