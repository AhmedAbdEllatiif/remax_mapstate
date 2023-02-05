import '../../common/enums/app_language.dart';
import '../models/filter_model.dart';

class GetBrokersByAreaParams {
  final String userToken;
  final List<FilterModel> filters;


  GetBrokersByAreaParams({
    required this.userToken,
    required this.filters,
  });
}
