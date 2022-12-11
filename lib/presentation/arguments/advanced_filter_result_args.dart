import 'package:remax_mapstate/presentation/logic/cubit/advanced_filter_projects/advanced_filter_projects_cubit.dart';

import '../../data/models/filter_model.dart';
import '../../domain/entities/project_entity.dart';

class AdvancedFilterResultArgs {
  final List<FilterModel> filters;

  AdvancedFilterResultArgs({
    required this.filters,
  });
}
