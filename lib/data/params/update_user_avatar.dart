class UpdateUserAvatarParams {
  final String userToken;
  final int userId;
  final String imgPath;

  UpdateUserAvatarParams({
    required this.userToken,
    required this.userId,
    required this.imgPath,
  });
}
