import '../../../../common/constants/api_constants.dart';

String updateAmbassadorMutation() => """
mutation updateAmbassadorMutation(\$${VariablesConstants.inputForm}:AmbassadorInput!){
  
  # mutation 
  updateAmbassador
  
  ######### mutation params #########
  (
      #==> inputForm      
     inputForm:\$${VariablesConstants.inputForm}
  )
  ########## End of params ###########
  
  ######### fields #########
  {
  
  ambassador{
  user{
     id
    }
  }
    
  }
  ########## end of fields #########
  
}
 """;
