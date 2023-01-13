import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

class UserDataItem extends StatelessWidget {
  final String keyData;
  final String value;

  const UserDataItem({Key? key, required this.keyData, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //==> data
        Text(
          keyData,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                //letterSpacing: 0.5,
                fontWeight: FontWeight.normal,
                color: AppColor.geeBung,
              ),
        ),

        //==> value
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                letterSpacing: 0.5,
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
        ),
      ],
    );
  }
}
