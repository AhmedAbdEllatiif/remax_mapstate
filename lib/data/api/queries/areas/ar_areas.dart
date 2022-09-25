import '../../../../common/constants/api_constants.dart';

String fetchArabicAreasQuery() => """
query ArabicAreas(\$${VariablesConstants.limit}:Int,\$${VariablesConstants.offset}:Int,,\$${VariablesConstants.orderBy}:String){
  regions(pageInfo:{limit:\$${VariablesConstants.limit},offset:\$${VariablesConstants.offset},orderBy:\$${VariablesConstants.orderBy}}){
    id
    arabicName
    priority
  }
}
 """;