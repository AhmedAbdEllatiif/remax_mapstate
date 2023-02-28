import '../../../../../common/constants/api_constants.dart';

String filterBrokers() => """
query ArabicProjectStatus(
\$${VariablesConstants.filters}:[DjangoFilterInput],
\$${VariablesConstants.pageInfo}:PageInfo
){
  
  # query 
  brokers
  
  ######### Query params #########
  (
     #==> Page info
     pageInfo: \$${VariablesConstants.pageInfo}
      #==> filters      
     filters:\$${VariablesConstants.filters}
  )
  ########## End of params ###########
  
  ######### Query body #########
  {
    user{
     id
      email
      phone
      firstName
      lastName
      
       mapEstateUser{
         avatar 
         favoriteProjects{
             id
          }
      } # end of mapEstateUser
    }
     reviews{
      brokerRating
      brokerReview
    }
    avatar
    brokerFiveStarsScore
    doneDealsCount
    yearsOfExperience
    dateOfBirth
  }
  ########## end of body #########
  
}
 """;