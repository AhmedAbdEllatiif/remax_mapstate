import '../../../../common/constants/api_constants.dart';

String registerNewUserRequest() => """
mutation registerNewUser(
\$${VariablesConstants.email}:String!,
\$${VariablesConstants.password}:String!
){
  
  # mutation 
  registerNewUser
  
  ######### mutation params #########
  (   
     email: \$${VariablesConstants.email}
     password1: \$${VariablesConstants.password}
     password2: \$${VariablesConstants.password}
  )
  ########## End of params ###########
  
  ######### fields #########
  {
    token
    success
    errors
  }
  ########## end of fields #########
  
}
 """;
