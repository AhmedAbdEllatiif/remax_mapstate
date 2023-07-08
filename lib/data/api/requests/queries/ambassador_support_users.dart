import '../../../../../common/constants/api_constants.dart';

String getAmbassadorSupportRequest() => """
query getAmbassadorSupport(
){
  ambassadorSupportUsers {
    id
    firstName
    lastName
    email
    phone
    mapEstateUser {
      whatsapp
      avatar
    }
  }
}
 """;
