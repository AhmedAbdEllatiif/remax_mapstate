import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import '../../common/constants/sizes.dart';
import '../../common/constants/translate_constatns.dart';
import '../themes/theme_color.dart';

class SeeAllWidget extends StatelessWidget {
  final Function() onSeeAllPressed;
  final String title;

  const SeeAllWidget({
    Key? key,
    required this.onSeeAllPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// title
        Text(
          title,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppColor.geeBung,
                fontWeight: FontWeight.bold,
              ),
        ),

        /// see all
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onSeeAllPressed,
          splashColor: AppColor.absoluteTransparentGeeBung,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_10.w,vertical:Sizes.dimen_3.h ),
            child: Text(
              TranslateConstants.seeAll.t(context),
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: AppColor.geeBung,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
