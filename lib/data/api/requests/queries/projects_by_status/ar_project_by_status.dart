import '../../../../../common/constants/api_constants.dart';

String fetchArabicProjectByStatusQuery() => """
query ArabicProjectByStatus(\$${VariablesConstants.filters}:[DjangoFilterInput],\$${VariablesConstants.pageInfo}:PageInfo){
  
  # query 
  projects
  
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
   id
    
    arabicName
    descriptionArabic
    type
    
    # images
    images
    
    # region
    region{
      id
      arabicName
      priority
    }
    # zone 
    zone{
      id
      arabicName
    }
    
    # services
    services{
      id
      arabicName
      icon
    }
    
    # priceFrom
    priceFrom
    
    # areaFrom
    areaFrom
    
    # finishingType
    finishingType{
      id
      arabicName
    }
    
    # deliveryYear
    deliveryYear
    
    # deliveryYear
    deliveryMonth
    
    # status
    status{
      id
      arabicName
    }
    
    # unittypeSet
    unittypeSet{
      id
      #==> unittypeSet.unitTypeName
      unitTypeName{
        id
        arabicName
      }
      #==> unittypeSet.layout
      layout{
        id
        arabicName
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
        
        arabicName
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
      arabicName
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