
import 'package:hive/hive.dart';
import 'package:remax_mapstate/data/tables/fav_project_table.dart';


abstract class LocalDataSource {
  /// To retrieve projects from local db
  Future<List<FavProjectTable>> getFavProject();

  /// To save a new project into local db
  Future<void> saveProject(FavProjectTable projectTable);

  /// To delete a project from local db
  Future<void> deleteProject(int projectId);

  /// to check if the project is a favorite project or not
  Future<bool> checkIfProjectIsFavorite(int projectId);
}

class LocalDataSourceImpl extends LocalDataSource {

  /// To retrieve projects from local db
  @override
  Future<bool> checkIfProjectIsFavorite(int projectId) async {
    final projectBox = await Hive.openBox('favProjectBox');
    return projectBox.containsKey(projectId);
  }

  /// To save a new project into local db
  @override
  Future<void> deleteProject(int projectId) async {
    final projectBox = await Hive.openBox('favProjectBox');
    await projectBox.delete(projectId);
  }

  /// To delete a project from local db
  @override
  Future<List<FavProjectTable>> getFavProject() async {
    final projectBox = await Hive.openBox('favProjectBox');
    final projectsIds = projectBox.keys;
    List<FavProjectTable> projects = [];
    for (var projectId in projectsIds) {
      projects.add(projectBox.get(projectId));
    }
    return projects;
  }

  /// to check if the project is a favorite project or not
  @override
  Future<void> saveProject(FavProjectTable projectTable) async {
    final projectBox = await Hive.openBox('favProjectBox');
    await projectBox.put(projectTable.id, projectTable);
  }
}
