class AddOrRemoveFavProjectParam {
  final String userToken;
  final String projectId;
  final int userId;
  final bool addToFavorite;

  AddOrRemoveFavProjectParam({
    required this.userToken,
    required this.projectId,
    required this.userId,
    required this.addToFavorite,
  });
}
