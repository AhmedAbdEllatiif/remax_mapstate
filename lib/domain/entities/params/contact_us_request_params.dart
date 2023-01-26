class ContactUsRequestParams {
  final String userToken;
  final int  userId;
  final String subject;
  final String body;

  ContactUsRequestParams({
    required this.userToken,
    required this.userId,
    required this.subject,
    required this.body,
  });
}
