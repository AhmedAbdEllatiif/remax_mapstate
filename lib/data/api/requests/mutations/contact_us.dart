import '../../../../common/constants/api_constants.dart';

String contactUsMutation() => """
mutation contactUsMutation(\$${VariablesConstants.inputForm}:ContactUsInput!){
  
  # mutation 
  contactUsRequest
  
  ######### mutation params #########
  (
      #==> inputForm      
     inputForm:\$${VariablesConstants.inputForm}
  )
  ########## End of params ###########
  
  ######### fields #########
  {
  
  contactUsRequest{
  user{
     id
    }
  }
    
  }
  ########## end of fields #########
  
}
 """;
