class UpdateUserMutationModel {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? password;
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

  Map<String, dynamic> toRegisterJson() {
    return {
      "email": email,
      "firstName": firstName,
      "phone": phone,
      "password": password,
      "groups": groups
    };
  }

  factory UpdateUserMutationModel.forCompletingBrokerData({
    required int userId,
    required int experienceYears,
    required List<int> favProjects,
  }) =>
      UpdateUserMutationModel(
        experienceYears: experienceYears,
        favProjects: favProjects,
      );

  Map<String, dynamic> toCompleteBrokerDataJson() {
    return {
      "yearsOfExperience": experienceYears,
      "firstName": firstName,
      "phone": lastName,
      "password": password,
      "groups": groups
    };
  }
}
