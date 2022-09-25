import 'package:remax_mapstate/data/models/filter_model.dart';
import 'package:remax_mapstate/data/models/page_info.dart';

import '../../common/enums/app_language.dart';

class FetchListParams {
  final AppLanguage appLanguage;
  final PageInfo pageInfo;
  final List<FilterModel> filters;

  FetchListParams({
    required this.appLanguage,
    required this.pageInfo,
    required this.filters,
  });
}
