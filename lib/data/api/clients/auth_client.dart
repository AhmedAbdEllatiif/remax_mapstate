import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../common/constants/api_constants.dart';

class AuthClient {
  GraphQLClient initAuthApi({required String token}) {
    final HttpLink httpLink = HttpLink(
      ApiConstants.authUrl,
      defaultHeaders: {
        'Authorization': "JWT $token",
      },
    );

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    return client;
  }

  dynamic get(
    String query, {
    required String token,
    Map<String, dynamic> variables = const {},
  }) async {
    /// QueryOptions
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variables,
    );

    // init graphQLClient
    final graphQLClient = initAuthApi(token: token);

    /// QueryResult
    final QueryResult result = await graphQLClient.query(options);

    if (result.hasException) {
      throw (result.exception!);
    } else {
      return result;
    }
  }

  dynamic mutate(
    String mutationFields, {
    required String token,
    Map<String, dynamic> variables = const {},
  }) async {
    // init graphQLClient
    final graphQLClient = initAuthApi(token: token);

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
