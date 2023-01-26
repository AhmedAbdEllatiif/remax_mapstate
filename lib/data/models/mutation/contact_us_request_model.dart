import 'package:remax_mapstate/domain/entities/params/contact_us_request_params.dart';

class ContactUsRequestModel {
  final int userId;
  final String subject;
  final String body;

  ContactUsRequestModel({
    required this.userId,
    required this.subject,
    required this.body,
  });

  factory ContactUsRequestModel.fromParams({
    required ContactUsRequestParams params,
  }) {
    return ContactUsRequestModel(
      userId: params.userId,
      subject: params.subject,
      body: params.body,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": userId,
      "body": body,
      "subject": subject,
    };
  }
}
