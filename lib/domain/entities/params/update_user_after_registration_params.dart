class UpdateUserGroupParams {
  final int userId;
  final int userGroup;
  final String firstName;
  final String phoneNumber;
  final String userToken;

  UpdateUserGroupParams({
    required this.userId,
    required this.firstName,
    required this.phoneNumber,
    required this.userToken,
    required this.userGroup,
  });
}
