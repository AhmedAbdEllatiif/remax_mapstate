import '../../../../common/constants/api_constants.dart';

String fetchEnglishProjectByStatusQuery() => """
query EnglishProjectByStatus(\$${VariablesConstants.filters}:[DjangoFilterInput],\$${VariablesConstants.pageInfo}:PageInfo){
  
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
    name
    arabicName
    description
    descriptionArabic
    type
    
    # region
    region{
      id
      name
      arabicName
      priority
    }
    # zone 
    zone{
      id
      name
      arabicName
    }
    
    # services
    services{
      id
      name
      arabicName
    }
    
    # priceFrom
    priceFrom
    
    # areaFrom
    areaFrom
    
    # finishingType
    finishingType{
      id
      name
      arabicName
    }
    
    # deliveryYear
    deliveryYear
    
    # deliveryYear
    deliveryMonth
    
    # status
    status{
      id
      name
      arabicName
    }
    
    # unittypeSet
    unittypeSet{
      id
      #==> unittypeSet.unitTypeName
      unitTypeName{
        id
        name
        arabicName
      }
      #==> unittypeSet.layout
      layout{
        id
        name
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
        name
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
      name
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