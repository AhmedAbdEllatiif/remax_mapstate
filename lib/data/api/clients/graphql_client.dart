import 'package:graphql/client.dart';

import '../../../common/constants/api_constants.dart';


 GraphQLClient initApi() {
final HttpLink httpLink = HttpLink(
ApiConstants.baseUrl,
defaultHeaders:{
//'x-api-key': ApiConstants.xApiKey,
});


final GraphQLClient client = GraphQLClient(
cache: GraphQLCache(),
link: httpLink,
);

return client;
}