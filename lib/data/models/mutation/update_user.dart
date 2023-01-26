import 'dart:io';

import 'package:http/http.dart' as http;

class UpdateUserMutationModel {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? password;
  final String? avatar;
  final int? experienceYears;
  final List<int>? groups;
  final List<int>? favProjects;
  final List<int>? unFavProjects;

  UpdateUserMutationModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.password,
    this.groups,
    this.avatar,
    this.experienceYears,
    this.favProjects,
    this.unFavProjects,
  });

  factory UpdateUserMutationModel.forRegistration(
          {required String email,
          required String firstName,
          required String phoneNumber,
          required String password,
          required int groups}) =>
      UpdateUserMutationModel(
          email: email,
          firstName: firstName,
          phone: phoneNumber,
          password: password,
          groups: [groups]);

  /*
  *
  *
  * To update user group
  *
  *
  * */
  factory UpdateUserMutationModel.forUpdatingUserAfterRegistration(
          {required int userId,
          required int groups,
          required String firstName,
          required String phoneNumber}) =>
      UpdateUserMutationModel(
        id: userId,
        firstName: firstName,
        phone: phoneNumber,
        groups: groups != -1 ? [groups] : [],
      );

  /*
  *
  *
  * To upload user avatar
  *
  *
  * */
  factory UpdateUserMutationModel.forUpdatingUserAvatar({
    required int userId,
    required String imagePath,
  }) =>
      UpdateUserMutationModel(
        id: userId,
        avatar: imagePath,
      );

  /// to convert to json
  Map<String, dynamic> toJson() {
    //==> map object to send
    final Map<String, dynamic> objectToSend = {};

    /// id
    if (id != null) {
      objectToSend.addAll({"pk": id});
    }

    /// email
    if (email != null) {
      objectToSend.addAll({"email": email});
    }

    /// phone
    if (phone != null) {
      objectToSend.addAll({"phone": phone});
    }

    /// password
    if (password != null) {
      objectToSend.addAll({"password": password});
    }

    /// groups
    if (groups != null) {
      objectToSend.addAll({"groups": groups});
    }

    /// firstName
    if (firstName != null) {
      objectToSend.addAll({"firstName": firstName});
    }

    /// lastName
    if (lastName != null) {
      objectToSend.addAll({"lastName": lastName});
    }

    /// experienceYears
    if (experienceYears != null) {
      objectToSend.addAll({"yearsOfExperience": experienceYears});
    }

    /// avatar
    if (avatar != null) {
      http.MultipartFile avatarFile = http.MultipartFile.fromBytes(
        "avatar", // field name
        File(avatar ?? "").readAsBytesSync(),
        filename: avatar,
      );

      objectToSend.addAll({"avatar": avatarFile});
    }

    return objectToSend;
  }
}
