class UpdateAmbassadorDataParams {
  final String userToken;
  final int ambassadorId;
  final String currentJobTitle;

  UpdateAmbassadorDataParams({
    required this.userToken,
    required this.ambassadorId,
    required this.currentJobTitle,
  });
}
