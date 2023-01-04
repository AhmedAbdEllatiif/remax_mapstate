class UpdateUserMutationModel {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? password;
  final List<int>? groups;
  final List<int>? favProjects;
  final List<int>? unFavProjects;

  UpdateUserMutationModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.groups,
    this.favProjects,
    this.unFavProjects,
  });

  factory UpdateUserMutationModel.forRegistration({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) =>
      UpdateUserMutationModel(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
      );

  Map<String, dynamic> toRegisterJson() {
    return {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "password": password,
    };
  }
}
