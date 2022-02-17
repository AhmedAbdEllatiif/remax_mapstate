import 'package:hive/hive.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/domain/entities/current_user.dart';

part 'current_user_table.g.dart';

// to generate movie_table.g.dart
// After build a new table
// add build_runner dependency
// add >> part 'fav_project_table.g.dart';
// run_command >> flutter packages pub run build_runner build
// to delete flutter packages pub run build_runner build --delete-conflicting-outputs

// Then inside main >>>
// init appDocumentDir
// final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
// Hive.init(appDocumentDir.path);
// Hive.registerAdapter(FavProjectTableAdapter());
@HiveType(typeId: 1)
class CurrentUserTable {


  @HiveField(0)
  final String currentUser;

  const CurrentUserTable({
    required this.currentUser,
  });


  /// Build CurrentUserTable from CurrentUserEntity
  factory CurrentUserTable.fromCurrentUserEntity(
      CurrentUserEntity currentUserEntity) {
    return CurrentUserTable(
      currentUser: currentUserEntity.userType.toShortString(),
    );
  }
}
