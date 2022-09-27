import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/all_areas/area_item.dart';
import 'package:remax_mapstate/presentation/widgets/stack_with_full_background.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/constants/translate_constatns.dart';
import '../../../../di/git_it.dart';
import '../../../../router/route_hepler.dart';
import '../../../arguments/project_by_status_args.dart';
import '../../../logic/cubit/areas/areas_cubit.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/loading_widget.dart';

class ProjectStatusAreasScreen extends StatefulWidget {
  final ProjectByStatusArguments projectByStatusArguments;

  const ProjectStatusAreasScreen(
      {Key? key, required this.projectByStatusArguments})
      : super(key: key);

  @override
  State<ProjectStatusAreasScreen> createState() => _AllAreasScreenState();
}

class _AllAreasScreenState extends State<ProjectStatusAreasScreen> {
  late AreasCubit _areasCubit;

  @override
  void initState() {
    super.initState();

    _areasCubit = getItInstance<AreasCubit>();
    _fetchAreas();
  }

  @override
  void dispose() {
    _areasCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _areasCubit,
      child: StackScaffoldWithFullBackground(
        appBarTitle: Text(
          TranslateConstants.allCities.t(context),
        ),
        body: BlocBuilder<AreasCubit, AreasState>(
          builder: (_, state) {
            return Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_4.h,
                bottom: Sizes.dimen_10.h,
                right: AppUtils.screenHorizontalPadding.w,
                left: AppUtils.screenHorizontalPadding.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// loading
                  if (state is LoadingAreas)
                    const Expanded(
                      child: Center(child: LoadingWidget()),
                    ),

                  /// loaded
                  if (state is AreasFetched)
                    Expanded(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.areas.length,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: Sizes.dimen_40.w,
                          // childAspectRatio: 1.0,
                          childAspectRatio: ResponsiveValue<double>(context,
                              defaultValue: 1.0,
                              valueWhen: const [
                                Condition.equals(name: TABLET, value: 1.2),
                                Condition.largerThan(name: TABLET, value: 1.2),
                                Condition.equals(name: MOBILE, value: 1.0),
                                Condition.smallerThan(name: MOBILE, value: 1.0),
                              ]).value!,
                          crossAxisSpacing: Sizes.dimen_20.w,
                        ),
                        itemBuilder: (_, index) {
                          return AreaItem(
                            areaName: state.areas[index].name,
                            onPressed: () => _navigateToProjectByStatusScreen(
                                context, state.areas[index].id),
                          );
                        },
                      ),
                    ),

                  if (state is ErrorWhileLoadingAreas)
                    Expanded(
                      child: Center(
                        child: AppErrorWidget(
                          appTypeError: state.appError.appErrorType,
                          onPressedRetry: () {
                            _fetchAreas();
                          },
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// To fetch areas
  void _fetchAreas() {
    _areasCubit.fetchAreas(context, limit: 50);
  }

  /// to navigate to ProjectDetailsScreen
  void _navigateToProjectByStatusScreen(BuildContext context, String areaId) =>
      RouteHelper().projectsByStatus(context,
          projectByStatusArguments: ProjectByStatusArguments(
            areaId: areaId,
            projectStatusEntity:
                widget.projectByStatusArguments.projectStatusEntity,
          ));
}
