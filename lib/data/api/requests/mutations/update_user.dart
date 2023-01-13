import '../../../../common/constants/api_constants.dart';

String updateUserMutation() => """
mutation updateUserMutation(\$${VariablesConstants.inputForm}:UserInput!){
  
  # mutation 
  updateUser
  
  ######### mutation params #########
  (
      #==> inputForm      
     inputForm:\$${VariablesConstants.inputForm}
  )
  ########## End of params ###########
  
  ######### fields #########
  {
    user{
     id
     firstName
     lastName
     email
     phone
    }
  }
  ########## end of fields #########
  
}
 """;
