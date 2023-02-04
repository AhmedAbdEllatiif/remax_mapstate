class RequestACallParams {
  final String userToken;
  final String userId;
  final String projectId;
  final String subject;
  final String body;

  RequestACallParams({
    required this.userToken,
    required this.userId,
    required this.projectId,
    required this.subject,
    required this.body,
  });
}
