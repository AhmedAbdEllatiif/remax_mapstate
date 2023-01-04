import 'package:graphql/client.dart';

class ApiClient {
  final GraphQLClient graphQLClient;

  const ApiClient({
    required this.graphQLClient,
  });

  dynamic get(String query, {Map<String, dynamic> variables = const {}}) async {
    /// QueryOptions
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variables,
    );

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
    Map<String, dynamic> variables = const {},
  }) async {
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
