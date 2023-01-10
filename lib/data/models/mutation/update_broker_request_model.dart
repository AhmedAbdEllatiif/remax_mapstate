class UpdateBrokerRequestModel {
  final int id;
  final int? experienceYears;
  final List<int>? favoriteRegions;

  UpdateBrokerRequestModel({
    required this.id,
    this.experienceYears,
    this.favoriteRegions,
  });

  Map<String, dynamic> toJson() {
    if (experienceYears != null && favoriteRegions != null) {
      return {
        "user": id,
        "yearsOfExperience": experienceYears,
        "favoriteRegions": favoriteRegions,
      };
    }

    if (experienceYears != null) {
      return {
        "user": id,
        "yearsOfExperience": experienceYears,
      };
    }

    if (favoriteRegions != null) {
      return {
        "user": id,
        "favoriteRegions": favoriteRegions,
      };
    }
    return {
      "user": id,
    };
  }
}
