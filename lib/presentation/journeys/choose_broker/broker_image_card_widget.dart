import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:remax_mapstate/common/constants/argument_constants.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';

import '../../themes/theme_color.dart';
import '../../widgets/cached_image_widget.dart';

class BrokerImageCardWidget extends StatelessWidget {
  final String posterPath;
  final bool assetImage;

  const BrokerImageCardWidget({
    Key? key,
    required this.posterPath,
    this.assetImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32.0,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
        child: assetImage
            ? Image.asset(
                posterPath,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(AssetsConstants.personPlaceHolder);
                },
              )
            : CachedImageWidget(
                height: double.infinity,
                imageUrl: posterPath,
                width: double.infinity,
                progressBarScale: 0.2,
                isCircle: false,
                boxFit: BoxFit.cover,
                errorWidget: Image.asset(
                  AssetsConstants.personPlaceHolder,
                  fit: BoxFit.cover,
                  color: AppColor.white,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Icon(
                      Icons.error,
                      color: AppColor.geeBung,
                    );
                  },
                ),
              ),
        // child: CachedNetworkImage(
        //   imageUrl: imageUrl,
        //   fit: BoxFit.cover,
        // ),
        //

        /*child: Image.network(
            '${ApiConstants.BASE_IMAGE_URL}$posterPath',
        ),*/
      ),
    );
  }
}
