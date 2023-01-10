import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';

import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/presentation/arguments/area_unit_types_args.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/container_with_gradient.dart';
import 'package:remax_mapstate/router/route_hepler.dart';

import '../../../../common/constants/app_utils.dart';

class AreaCardWidget extends StatelessWidget {
  final AreaEntity area;

  const AreaCardWidget({Key? key, required this.area}) : super(key: key);

  /// to navigate to ProjectsScreen
  void _navigateToAreaScreen(BuildContext context) => RouteHelper()
      .areaScreen(context, areaArgument: AreaUnitTypesArguments(area: area));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToAreaScreen(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.bgItemBlack,
          borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
        ),
        child: Center(
          child: Text(
            area.name,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: AppColor.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      // CircleAvatar(
      //   backgroundColor: AppColor.geeBung,
      //   child: ContainerWithGradient(
      //     shape: BoxShape.circle,
      //     child: Center(
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Text(
      //           area.name,
      //           maxLines: 2,
      //           textAlign: TextAlign.center,
      //           overflow: TextOverflow.ellipsis,
      //           style: Theme.of(context).textTheme.bodyText2!.copyWith(
      //               color: AppColor.black,
      //               fontWeight: FontWeight.bold
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
