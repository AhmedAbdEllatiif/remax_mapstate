import '../../../../../common/constants/api_constants.dart';

String fetchEnglishFavProjectsQuery() => """
query getFavoriteProjects(
\$${VariablesConstants.userPk}:Int,
\$${VariablesConstants.filters}:[DjangoFilterInput],
\$${VariablesConstants.pageInfo}:PageInfo
){
  
  # query 
  favoriteProjects
  
 ######### Query params #########
  (
     #==> userPk
     userPk: \$${VariablesConstants.userPk}
     #==> Page info
     pageInfo: \$${VariablesConstants.pageInfo}
      #==> filters      
     filters:\$${VariablesConstants.filters}
  )
  ########## End of params ###########
  
  ######### Query body #########
  {
   id
    name
    
    description
    
    type
    
     # images
    images
    
    # region
    region{
      id
      name
      
      priority
    }
    # zone 
    zone{
      id
      name
      
    }
    
    # services
    services{
      id
      name
      icon
    }
    
    # priceFrom
    priceFrom
    
    # areaFrom
    areaFrom
    
    # finishingType
    finishingType{
      id
      name
      
    }
    
    # deliveryYear
    deliveryYear
    
    # deliveryYear
    deliveryMonth
    
    # status
    status{
      id
      name
      
    }
    
    # unittypeSet
    unittypeSet{
      id
      #==> unittypeSet.unitTypeName
      unitTypeName{
        id
        name
        
      }
      #==> unittypeSet.layout
      layout{
        id
        name
        
      }
      priceFrom
      priceTo
      areaFrom
      areaTo
      percentage
      numberOfYears
      #==> unittypeSet.finishingType
      finishingType{
        id
        name
        
      }
    } # end of unittypeSet
    
    # project location
    location{
      id
      locationText
      address
    }
    
    # project paymentplan
    paymentplan{
      id
      percentage
      numberOfYears
    }
    
    # projectplanSet
    projectplanSet{
      id
      name
    }
    
    # developer
    developer{
      id
      name
      
      logo
      #==> developercontact
      developercontact{
        id
        firstName
        lastName
        personalImage
        phone
      }
      #==> developer location
      location{
        id
        locationText
        address
        geometry
      }
    }
  }
  ########## end of body #########
  
}
 """;
