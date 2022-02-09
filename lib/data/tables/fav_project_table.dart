import 'package:hive/hive.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';

part 'fav_project_table.g.dart';

// to generate movie_table.g.dart
// After build a new table
// add build_runner dependency
// add >> part 'fav_project_table.g.dart';
// run_command >> flutter packages pub run build_runner build

// Then inside main >>>
// init appDocumentDir
// final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
// Hive.init(appDocumentDir.path);
// Hive.registerAdapter(FavProjectTableAdapter());
@HiveType(typeId: 0)
class FavProjectTable extends ProjectEntity{

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String imageUrl;

  const FavProjectTable({
    required this.id,
    required this.name,
    required this.imageUrl,
  }) : super(id: id,name: name,imageUrl: imageUrl,description: '');

  factory FavProjectTable.fromProjectEntity(ProjectEntity projectEntity){
    return FavProjectTable(id: projectEntity.id, name: projectEntity.name, imageUrl: projectEntity.imageUrl);
  }
}