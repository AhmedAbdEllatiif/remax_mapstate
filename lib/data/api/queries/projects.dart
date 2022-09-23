String fetchProjectsQuery() => """
query Projects {
  projects {
    # Basic
    id
    name
    arabicName
    description
    descriptionArabic
    priceFrom
    areaFrom
    deliveryYear
    
    # Project Type
    type
    
    # Status
    status{
      name
      arabicName
    }
    
    # Region and zone
    region {
      name
      arabicName
    }
    zone {
      name
      arabicName
    }
    
    # Services
    services{
      name
      arabicName
    }
    
    # Unit Types
    unittypeSet{
      unitTypeName{
        name
        arabicName
      }
      layout{
        name
        arabicName
      }
      priceFrom
      areaFrom
      percentage
      finishingType{
        name
        arabicName
      }
    }
    
    # Payment Plan
    paymentplan{
      percentage
      numberOfYears
    }
    
    # Project Location
    location{
      geometry
      address
    }
    
    # Developer Information
    developer {
      name
    }
    
  }
}

 """;