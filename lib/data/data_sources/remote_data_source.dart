import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/data/models/area_model.dart';
import 'package:remax_mapstate/data/models/project_model.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';

abstract class RemoteDataSource {
  /// return top projects
  Future<List<ProjectModel>> getTopProjects();

  /// return areas
  Future<List<AreaModel>> getAreas();
}

class RemoteDateSourceImpl extends RemoteDataSource {
  List<ProjectModel> projects() {
    return [
      const ProjectModel(
          id: 0,
          imageUrl: AssetsConstants.mountainViewImagePath,
          name: "Mountain View",
          description: "No Desc"),
      const ProjectModel(
          id: 1,
          imageUrl: AssetsConstants.promotionImagePath,
          name: "Promotion",
          description: "No Desc"),
      const ProjectModel(
          id: 2,
          imageUrl: AssetsConstants.mountainViewImagePath,
          name: "Mountain View",
          description: "No Desc"),
      const ProjectModel(
          id: 3,
          imageUrl: AssetsConstants.promotionImagePath,
          name: "Promotion",
          description: "No Desc"),
      const ProjectModel(
          id: 4,
          imageUrl: AssetsConstants.mountainViewImagePath,
          name: "Mountain View",
          description: "No Desc"),
      const ProjectModel(
          id: 5,
          imageUrl: AssetsConstants.promotionImagePath,
          name: "Promotion",
          description: "No Desc"),
      const ProjectModel(
          id: 6,
          imageUrl: AssetsConstants.mountainViewImagePath,
          name: "Mountain View",
          description: "No Desc"),
      const ProjectModel(
          id: 7,
          imageUrl: AssetsConstants.promotionImagePath,
          name: "Promotion",
          description: "No Desc"),
      const ProjectModel(
          id: 8,
          imageUrl: AssetsConstants.mountainViewImagePath,
          name: "Mountain View",
          description: "No Desc"),
      const ProjectModel(
          id: 9,
          imageUrl: AssetsConstants.promotionImagePath,
          name: "Promotion",
          description: "No Desc"),
      const ProjectModel(
          id: 10,
          imageUrl: AssetsConstants.mountainViewImagePath,
          name: "Mountain View",
          description: "No Desc"),
    ];
  }

  List<AreaModel> areas(){
    return [
    const AreaModel(id: 0,title: 'New Cairo'),
    const AreaModel(id: 1,title: 'New Capital'),
    const AreaModel(id: 2,title: 'Zayed'),
    const AreaModel(id: 3,title: 'New Zayed'),
    const AreaModel(id: 4,title: 'October'),
    const AreaModel(id: 5,title: 'New Cairo'),
    const AreaModel(id: 6,title: 'New Cairo'),
    const AreaModel(id: 7,title: 'October'),
    const AreaModel(id: 8,title: 'New October'),
    const AreaModel(id: 9,title: 'New Cairo'),
    ];
  }


  @override
  Future<List<AreaModel>> getAreas() async {
    final myAreas = await areas();
    return myAreas;
  }

  @override
  Future<List<ProjectModel>> getTopProjects() async {
    final myProjects = await projects();
    return myProjects;
  }
}
