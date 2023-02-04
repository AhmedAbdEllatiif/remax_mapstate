import '../../common/enums/app_language.dart';

class FetchFavProjectsParams {
  final String userToken;
  final String userId;
  final AppLanguage appLanguage;
  final int limit;
  final int offset;
  final String orderBy;

  FetchFavProjectsParams({
    required this.userToken,
    required this.userId,
    required this.appLanguage,
    this.limit = 50,
    this.offset = 0,
    this.orderBy = "",
  });
}
