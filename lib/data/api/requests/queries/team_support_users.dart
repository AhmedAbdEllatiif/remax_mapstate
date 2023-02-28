import '../../../../../common/constants/api_constants.dart';

String getTeamSupportRequest() => """
query getTeamSupport(
){
  teamSupportUsers {
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
