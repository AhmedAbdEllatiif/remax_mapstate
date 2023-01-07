import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../common/constants/api_constants.dart';

class AuthClient {
  GraphQLClient initAuthApi() {
    final HttpLink httpLink = HttpLink(ApiConstants.authUrl, defaultHeaders: {
//'x-api-key': ApiConstants.xApiKey,
    });

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    return client;
  }

  dynamic mutate(
    String mutationFields, {
    Map<String, dynamic> variables = const {},
  }) async {
    // init graphQLClient
    final graphQLClient = initAuthApi();

    /// MutationOptions
    final MutationOptions options = MutationOptions(
      document: gql(mutationFields),
      variables: variables,
    );

    /// QueryResult
    final QueryResult result = await graphQLClient.mutate(options);

    if (result.hasException) {
      throw (result.exception!);
    } else {
      return result;
    }
  }
}
