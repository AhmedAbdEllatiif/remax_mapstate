import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/data/models/area_model.dart';
import 'package:remax_mapstate/data/models/broker_model.dart';
import 'package:remax_mapstate/data/models/contact_developer.dart';
import 'package:remax_mapstate/data/models/project_model.dart';
import 'package:remax_mapstate/data/models/project_status.dart';
import 'package:remax_mapstate/data/models/team_support_model.dart';
import 'package:remax_mapstate/data/models/unit_type_model.dart';

abstract class RemoteDataSource {
  /// return top projects
  Future<List<ProjectModel>> getTopProjects();

  /// return residential projects
  Future<List<ProjectModel>> getResidentialProjects(int areaId);

  /// return commercial projects
  Future<List<ProjectModel>> getCommercialProjects(int areaId);

  /// return areas
  Future<List<AreaModel>> getAreas();

  /// return list of brokers
  Future<List<BrokerModel>> getAreaBrokers();

  /// return list project status
  Future<List<ProjectStatusModel>> getProjectStatus();

  /// return list unitTypes status
  Future<List<UnitTypeModel>> getResidentialUnitTypesByArea();

  /// return the developer contact data
  Future<ContactDeveloperModel> getDeveloperContact(int developerId);

  /// return team support data
  Future<TeamSupportModel> getTeamSupport();
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

  List<AreaModel> areas() {
    return [
      const AreaModel(id: 0, title: 'New Cairo'),
      const AreaModel(id: 1, title: 'New Capital'),
      const AreaModel(id: 2, title: 'Zayed'),
      const AreaModel(id: 3, title: 'New Zayed'),
      const AreaModel(id: 4, title: 'October'),
      const AreaModel(id: 5, title: 'Sokhna'),
      /*const AreaModel(id: 6,title: 'New Cairo'),
    const AreaModel(id: 7,title: 'October'),
    const AreaModel(id: 8,title: 'New October'),
    const AreaModel(id: 9,title: 'New Cairo'),*/
    ];
  }

  List<ProjectStatusModel> projectStatus() {
    return [
      const ProjectStatusModel(
          id: 0, name: 'Ready To move', image: AssetsConstants.readyToMove),
      const ProjectStatusModel(
          id: 1,
          name: 'Under Construction',
          image: AssetsConstants.underConstruction),
      const ProjectStatusModel(
          id: 2, name: 'Off Plans', image: AssetsConstants.offPlan),
    ];
  }

  List<BrokerModel> areaBrokers() {
    return const [
      BrokerModel(
          id: 0,
          age: 33,
          image: AssetsConstants.person1,
          name: "John",
          rating: 3.5,
          totalDoneDeals: 50,
          whatsappNum: '+2001124466700',
          phoneNum: '+2001124466700'),
      BrokerModel(
          id: 1,
          age: 28,
          image: AssetsConstants.person1,
          name: "Micheal",
          rating: 4.5,
          totalDoneDeals: 180,
          whatsappNum: '+2001124466700',
          phoneNum: '+2001124466700'),
      BrokerModel(
          id: 2,
          age: 33,
          image: AssetsConstants.person1,
          name: "John",
          rating: 3.5,
          totalDoneDeals: 50,
          whatsappNum: '+2001124466700',
          phoneNum: '+2001124466700'),
      BrokerModel(
          id: 3,
          age: 28,
          image: AssetsConstants.person1,
          name: "Micheal",
          rating: 4.5,
          totalDoneDeals: 180,
          whatsappNum: '+2001124466700',
          phoneNum: '+2001124466700'),
      BrokerModel(
          id: 4,
          age: 33,
          image: AssetsConstants.person1,
          name: "John",
          rating: 3.5,
          totalDoneDeals: 50,
          whatsappNum: '+2001124466700',
          phoneNum: '+2001124466700'),
      BrokerModel(
          id: 5,
          age: 28,
          image: AssetsConstants.person1,
          name: "Micheal",
          rating: 4.5,
          totalDoneDeals: 180,
          whatsappNum: '+2001124466700',
          phoneNum: '+2001124466700'),
      BrokerModel(
          id: 6,
          age: 33,
          image: AssetsConstants.person1,
          name: "John",
          rating: 3.5,
          totalDoneDeals: 50,
          whatsappNum: '+2001124466700',
          phoneNum: '+2001124466700'),
      BrokerModel(
          id: 7,
          age: 28,
          image: AssetsConstants.person1,
          name: "Micheal",
          rating: 4.5,
          totalDoneDeals: 180,
          whatsappNum: '+2001124466700',
          phoneNum: '+2001124466700'),
    ];
  }

  List<UnitTypeModel> unitTypes() {
    return [
      const UnitTypeModel(id: 0, name: 'Twin House'),
      const UnitTypeModel(id: 1, name: 'Villa'),
      const UnitTypeModel(id: 2, name: 'Town House'),
      const UnitTypeModel(id: 2, name: 'Duplex'),
      const UnitTypeModel(id: 0, name: 'Twin House'),
      const UnitTypeModel(id: 1, name: 'Villa'),
      const UnitTypeModel(id: 2, name: 'Town House'),
      const UnitTypeModel(id: 2, name: 'Duplex'),
    ];
  }

  ContactDeveloperModel developerContact() {
    return const ContactDeveloperModel(
      id: 0,
      developerName: "Mountain View",
      empFirstName: "Jack",
      empSecondName: "Alison",
      latitude: 37.759392,
      longitude: -122.5107336,
      image: AssetsConstants.person2,
      empPhoneNum: "+2001124466700",
    );
  }

  ContactDeveloperModel developerContactWithOutImage() {
    return const ContactDeveloperModel(
      id: 1,
      developerName: "Mountain View",
      empFirstName: "Jack",
      empSecondName: "Alison",
      latitude: null,
      longitude: null,
      empPhoneNum: "+2001124466700",
    );
  }

  TeamSupportModel teamSupportModel() {
    return const TeamSupportModel(
      id: 0,
      firstName: "Haytham",
      lastName: "Hagrasy",
      phoneNum: "+2001124466700",
      whatsappNum: '+2001124466700',
      image: AssetsConstants.person2,
    );
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
  Future<List<BrokerModel>> getAreaBrokers() async {
    final brokers = await areaBrokers();
    return brokers;
  }

  @override
  Future<List<ProjectModel>> getCommercialProjects(int areaId) async {
    //final myProjects = await projects();
    final List<ProjectModel> myProjects = [];
    return myProjects;
  }

  @override
  Future<List<ProjectModel>> getResidentialProjects(int areaId) async {
    final myProjects = await projects();
    return myProjects;
  }

  /// return list project status
  @override
  Future<List<ProjectStatusModel>> getProjectStatus() async {
    final status = await projectStatus();
    return status;
  }

  /// return list unitTypes status
  @override
  Future<List<UnitTypeModel>> getResidentialUnitTypesByArea() async {
    final uniTypes = await unitTypes();
    return uniTypes;
  }

  /// return the developer contact data
  @override
  Future<ContactDeveloperModel> getDeveloperContact(int developerId) async {
    final developerContactData = developerId % 2 == 0
        ? await developerContact()
        : await developerContactWithOutImage();
    return developerContactData;
  }

  @override
  Future<TeamSupportModel> getTeamSupport() async {
    final teamSupport = await teamSupportModel();
    return teamSupport;
  }
}
