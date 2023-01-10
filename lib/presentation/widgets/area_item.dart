import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';

import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';
import 'container_with_gradient.dart';

class AreaItem extends StatelessWidget {
  final String areaName;
  final Function() onPressed;

  const AreaItem({Key? key, required this.areaName, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      /// InkWell
      child: InkWell(
        onTap: onPressed,
        splashColor: AppColor.geeBung.withOpacity(0.5),
        borderRadius:
            BorderRadius.all(Radius.circular(AppUtils.cornerRadius.w)),

        /// ContainerWithGradient
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColor.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(Sizes.dimen_6.w),
              child: Text(
                areaName,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
