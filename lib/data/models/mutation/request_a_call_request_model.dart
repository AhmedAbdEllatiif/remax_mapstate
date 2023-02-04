import 'package:remax_mapstate/data/params/request_a_call_params.dart';

class RequestCallRequestModel {
  final int userId;
  final int projectId;
  final String subject;
  final String body;

  RequestCallRequestModel({
    required this.userId,
    required this.subject,
    required this.projectId,
    required this.body,
  });

  factory RequestCallRequestModel.fromParams({
    required RequestACallParams params,
  }) {
    return RequestCallRequestModel(
      userId: int.tryParse(params.userId) ?? -1,
      projectId: int.tryParse(params.projectId) ?? -1,
      subject: params.subject,
      body: params.body,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": userId,
      "project": projectId,
      "body": body,
      "subject": subject,
    };
  }
}
