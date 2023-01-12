String getProfile() => """
query getProfile{
  
  # query  
  me
  ######### fields #########
      {
          pk
          email
          firstName
          lastName
          lastLogin
       } 
  
  ########## end of fields #########
  
}
 """;
