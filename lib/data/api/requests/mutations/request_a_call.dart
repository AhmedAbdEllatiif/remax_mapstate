import '../../../../common/constants/api_constants.dart';

String requestCallMutation() => """
mutation requestCallMutation(
\$${VariablesConstants.inputForm}:ProjectCallRequestInput!
){
  
  # mutation 
  projectCallRequest
  
  ######### mutation params #########
  (
      #==> inputForm      
     inputForm:\$${VariablesConstants.inputForm}
  )
  ########## End of params ###########
  
  ######### fields #########
  {
  
 
    
  }
  ########## end of fields #########
  
}
 """;
