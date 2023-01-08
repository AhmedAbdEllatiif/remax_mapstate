import '../../../common/constants/api_constants.dart';

String getBrokersQuery() => """
query getBroker(
\$${VariablesConstants.pk}:Int,
\$${VariablesConstants.filters}:[DjangoFilterInput],
\$${VariablesConstants.pageInfo}:PageInfo
){
  
  # query 
  brokers
  
  ######### Query params #########
  (
     #==> pk
     pk: \$${VariablesConstants.pk}
      #==> Page info
     pageInfo: \$${VariablesConstants.pageInfo}
      #==> filters      
     filters:\$${VariablesConstants.filters}
  ){
  ########## End of params ###########
  
  ######### Query body #########
  user {
      id
      email
      phone
      firstName
      lastName
    }
    yearsOfExperience
  ########## end of body #########
  }
}
 """;
