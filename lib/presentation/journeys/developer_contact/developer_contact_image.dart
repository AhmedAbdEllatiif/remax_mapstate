import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';

import '../../../common/constants/assets_constants.dart';
import '../../../common/constants/sizes.dart';
import '../../../common/screen_utils/screen_util.dart';

class DeveloperContactImage extends StatelessWidget {
  final String imageUrl;

  const DeveloperContactImage({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32.0,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (BuildContext context, Object exception,
              StackTrace? stackTrace) {
            return  Image.asset(AssetsConstants.personPlaceHolder);
          },
        ),
        /*CachedNetworkImage(
          imageUrl: '${ApiConstants.BASE_IMAGE_URL}$posterPath',
          fit: BoxFit.cover,
        ),*/
        /*child: Image.network(
            '${ApiConstants.BASE_IMAGE_URL}$posterPath',
        ),*/
      ),
    );
  }
}
//;
