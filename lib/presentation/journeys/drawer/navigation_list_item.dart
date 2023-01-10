import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

class NavigationListItem extends StatelessWidget {
  final String title;
  final Icon icon;
  final Function() onPressed;

  const NavigationListItem(
      {Key? key, required this.title, required this.onPressed, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              color: Theme.of(context).primaryColor.withOpacity(0.7),
            )
          ],
        ),
        child: ListTile(
          leading: icon,
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: AppColor.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}


// For subItems
class NavigationSubListItem extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const NavigationSubListItem(
      {Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              color: Theme.of(context).primaryColor.withOpacity(0.7),
            )
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColor.white
            ),
          ),
        ),
      ),
    );
  }
}