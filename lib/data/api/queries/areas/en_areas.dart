import 'package:remax_mapstate/common/constants/api_constants.dart';

String fetchEnglishAreasQuery() => """
query EnglishAreas(\$${VariablesConstants.limit}:Int,\$${VariablesConstants.offset}:Int,,\$${VariablesConstants.orderBy}:String){
  regions(pageInfo:{limit:\$${VariablesConstants.limit},offset:\$${VariablesConstants.offset},orderBy:\$${VariablesConstants.orderBy}}){
    id
    name
    priority
  }
}
 """;