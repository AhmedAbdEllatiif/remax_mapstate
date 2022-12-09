import 'package:remax_mapstate/common/constants/assets_constants.dart';

import '../../common/constants/translate_constatns.dart';

class ProjectStatusEntity {
  final String id;
  final String name;
  final String image;

  const ProjectStatusEntity({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ProjectStatusEntity.empty() => const ProjectStatusEntity(
        id: "-1",
        name: TranslateConstants.allProjects,
        image: AssetsConstants.readyToMoveImg,
      );
}
