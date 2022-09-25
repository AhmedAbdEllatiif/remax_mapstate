import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';

import '../../../common/constants/sizes.dart';
import '../../themes/theme_color.dart';
import '../../widgets/container_with_gradient.dart';

class AreaItem extends StatelessWidget {
  final String areaName;

  const AreaItem({Key? key, required this.areaName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(AppUtils.cornerRadius.w))),
      child: InkWell(
        onTap: () {},
        splashColor: AppColor.geeBung,
        borderRadius: BorderRadius.all(
          Radius.circular(AppUtils.cornerRadius.w),
        ),
        child: ContainerWithGradient(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(Sizes.dimen_6.w),
              child: Text(
                areaName,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
