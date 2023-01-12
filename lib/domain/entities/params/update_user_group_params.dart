class UpdateUserGroupParams {
  final int userId;
  final int userGroup;
  final String userToken;

  UpdateUserGroupParams({
    required this.userId,
    required this.userToken,
    required this.userGroup,
  });
}
