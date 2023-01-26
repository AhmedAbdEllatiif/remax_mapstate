import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';

import '../../../common/constants/assets_constants.dart';
import '../../../common/constants/sizes.dart';
import '../../widgets/cached_image_widget.dart';

class ContactImage extends StatelessWidget {
  final String imageUrl;
  final bool assetImage;

  const ContactImage(
      {Key? key, required this.imageUrl, this.assetImage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32.0,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
        child: assetImage
            ? Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(AssetsConstants.personPlaceHolder);
                },
              )
            : CachedImageWidget(
                height: double.infinity,
                imageUrl: imageUrl,
                width: double.infinity,
                progressBarScale: 0.2,
                isCircle: false,
                boxFit: BoxFit.cover,
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
//;
