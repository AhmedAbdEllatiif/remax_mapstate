import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/data/models/area_model.dart';
import 'package:remax_mapstate/data/models/broker_model.dart';
import 'package:remax_mapstate/data/models/project_model.dart';

abstract class RemoteDataSource {
  /// return top projects
  Future<List<ProjectModel>> getTopProjects();

  /// return areas
  Future<List<AreaModel>> getAreas();

  /// return list of brokers
  Future<List<BrokerModel>> getAreaBrokers();
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
    const AreaModel(id: 5,title: 'Sokhna'),
    /*const AreaModel(id: 6,title: 'New Cairo'),
    const AreaModel(id: 7,title: 'October'),
    const AreaModel(id: 8,title: 'New October'),
    const AreaModel(id: 9,title: 'New Cairo'),*/
    ];
  }

  List<BrokerModel> areaBrokers(){
    return const [
      BrokerModel(id: 0, age: 33, image: AssetsConstants.person1, name: "John", rating: 3.5, totalDoneDeals: 50,whatsappNum: '01005787483',phoneNum:'01007715117' ),
      BrokerModel(id: 1, age: 28, image: AssetsConstants.person1, name: "Micheal", rating: 4.5, totalDoneDeals: 180,whatsappNum: '01005787483',phoneNum:'01007715117' ),
      BrokerModel(id: 2, age: 33, image: AssetsConstants.person1, name: "John", rating: 3.5, totalDoneDeals: 50,whatsappNum: '01005787483',phoneNum:'01007715117' ),
      BrokerModel(id: 3, age: 28, image: AssetsConstants.person1, name: "Micheal", rating: 4.5, totalDoneDeals: 180,whatsappNum: '01005787483',phoneNum:'01007715117' ),
      BrokerModel(id: 4, age: 33, image: AssetsConstants.person1, name: "John", rating: 3.5, totalDoneDeals: 50,whatsappNum: '01005787483',phoneNum:'01007715117' ),
      BrokerModel(id: 5, age: 28, image: AssetsConstants.person1, name: "Micheal", rating: 4.5, totalDoneDeals: 180,whatsappNum: '01005787483',phoneNum:'01007715117' ),
      BrokerModel(id: 6, age: 33, image: AssetsConstants.person1, name: "John", rating: 3.5, totalDoneDeals: 50,whatsappNum: '01005787483',phoneNum:'01007715117' ),
      BrokerModel(id: 7, age: 28, image: AssetsConstants.person1, name: "Micheal", rating: 4.5, totalDoneDeals: 180,whatsappNum: '01005787483',phoneNum:'01007715117' ),
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

  @override
  Future<List<BrokerModel>> getAreaBrokers() async{
    final brokers = await areaBrokers();
    return brokers;
  }
}
