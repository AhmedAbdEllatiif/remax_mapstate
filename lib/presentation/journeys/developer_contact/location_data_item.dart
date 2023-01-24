import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/functions/show_snack_bar.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../../data/params/open_map_params.dart';
import '../../logic/bloc/launch_apps/launch_apps_bloc.dart';

class LocationDataItem extends StatefulWidget {
  final String dataKey;
  final dynamic value;
  final LocationEntity locationEntity;
  final String locationName;
  final LaunchAppsBloc launchAppsBloc;

  const LocationDataItem({
    Key? key,
    required this.dataKey,
    this.value,
    required this.locationEntity,
    required this.locationName,
    required this.launchAppsBloc,
  }) : super(key: key);

  @override
  State<LocationDataItem> createState() => _LocationDataItemState();
}

class _LocationDataItemState extends State<LocationDataItem> {
  late final LaunchAppsBloc _launchAppsBloc;

  @override
  void initState() {
    super.initState();
    _launchAppsBloc = widget.launchAppsBloc;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LaunchAppsBloc, LaunchAppsState>(
      bloc: _launchAppsBloc,
      listener: (context, state) {
        if (state is ErrorWhileOpenMap) {
          showSnackBar(
            context,
            message: TranslateConstants.somethingWentWrong.t(context),
          );
        }
      },
      builder: (context, state) {
        /// loading
        if (state is LoadingToLaunchMap) {
          return const Center(
            child: LoadingWidget(),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// head section text
            RichText(
              text: TextSpan(
                text: widget.dataKey,
                style: Theme.of(context).textTheme.geryCaption,
                children: [
                  TextSpan(
                    text: " ${TranslateConstants.headOffice.t(context)}",
                    style: Theme.of(context).textTheme.geryCaption,
                  )
                ],
              ),
            ),

            /// get directions
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_20.w)),
              child: InkWell(
                onTap: () {
                  _openMap();
                },
                splashColor: AppColor.black,
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.dimen_6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.value,
                        style: Theme.of(context)
                            .textTheme
                            .boldVulcanBodyText2
                            .copyWith(color: AppColor.royalBlue),
                      ),
                      SizedBox(
                        width: Sizes.dimen_4.w,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColor.royalBlue,
                        size: Sizes.dimen_8.h,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void _openMap() {
    // init params
    final openMapParams = OpenMapParams(
      latitude: widget.locationEntity.latitude,
      longitude: widget.locationEntity.longitude,
      locationName: widget.locationName,
    );

    // add event
    _launchAppsBloc.add(OpenMapEvent(openMapParams: openMapParams));
  }
}
