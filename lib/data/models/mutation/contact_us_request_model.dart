import 'package:remax_mapstate/domain/entities/params/contact_us_request_params.dart';

class ContactUsRequestModel {
  final String title;
  final String subject;

  ContactUsRequestModel({
    required this.title,
    required this.subject,
  });

  factory ContactUsRequestModel.fromParams({
    required ContactUsRequestParams params,
  }) {
    return ContactUsRequestModel(
      title: params.title,
      subject: params.subject,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "subject": subject,
    };
  }
}
