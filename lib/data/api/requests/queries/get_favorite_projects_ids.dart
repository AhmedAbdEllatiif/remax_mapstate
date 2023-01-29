import '../../../../../common/constants/api_constants.dart';

String getFavoriteProjectIdsQuery() => """
query getPro(
\$${VariablesConstants.pk}:Int,
){
  
  # query name
  users
  
  ######### Query params #########
  (
     #==> pk
     pk: \$${VariablesConstants.pk}
  ){
  ########## End of params ###########
  
  ######### Query body #########
  
  user {
        mapEstateUser{
            favoriteProjects{
                    id
                 } # end of favoriteProjects
                 
      } # end of mapEstateUser
      
    } # end of user
    
  ########## end of body #########
  }
}
 """;
