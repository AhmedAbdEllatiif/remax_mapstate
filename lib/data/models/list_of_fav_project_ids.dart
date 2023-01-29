import 'dart:developer';

List<int> listOfProjectByIds(dynamic data) {
  final List<int> favProjects = [];
  if (data == null) throw Exception("listOfProjectByIds >> data is null");

  if (data["users"] == null) {
    throw Exception("listOfProjectByIds >> data[\"users\"] is null");
  }

  if ((data["users"] as List).isEmpty) {
    throw Exception(
        "listOfProjectByIds >> data[\"users\"] is not null  but empty");
  }

  if (data["users"][0]["user"] == null) {
    throw Exception("listOfProjectByIds >> user inside users is null");
  }

  log("firstUser >> ${data["users"][0]["user"]} \n\n");
  if (data["users"][0]["user"]["mapEstateUser"] == null) {
    throw Exception(
        "listOfProjectByIds >> user[\"mapEstateUser\"] inside users is null");
  }

  if (data["users"][0]["user"]["mapEstateUser"]["favoriteProjects"] == null) {
    throw Exception(
        "listOfProjectByIds >> user[\"mapEstateUser\"][\"favoriteProjects\"] "
        "inside users is null");
  }

  for (var element in (data["users"][0]["user"]["mapEstateUser"]
      ["favoriteProjects"] as List)) {
    final id = int.tryParse(element["id"]) ?? -1;

    favProjects.add(id);
  }

  return favProjects;
}
