import '../../../../common/constants/api_constants.dart';

String updateBrokerMutation() => """
mutation updateBrokerMutation(\$${VariablesConstants.inputForm}:BrokerInput!){
  
  # mutation 
  updateBroker
  
  ######### mutation params #########
  (
      #==> inputForm      
     inputForm:\$${VariablesConstants.inputForm}
  )
  ########## End of params ###########
  
  ######### fields #########
  {
  
  broker{
  user{
     id
    }
  }
    
  }
  ########## end of fields #########
  
}
 """;
