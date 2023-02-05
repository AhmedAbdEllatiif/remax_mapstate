import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';

import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';
import 'custom_circular_progress_bar.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double progressBarScale;
  final bool isCircle;
  final BoxFit boxFit;
  final Widget? errorWidget;

  const CachedImageWidget({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
    required this.progressBarScale,
    required this.isCircle,
    this.boxFit = BoxFit.cover,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      /// imageUrl
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.contain,

      /// imageBuilder
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          //borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10.w)),
          image: DecorationImage(
            image: imageProvider,
            fit: boxFit,
            // colorFilter: ColorFilter.mode(
            //   Colors.red,
            //   BlendMode.colorBurn,
            // ),
          ),
        ),
      ),

      /// progressBar
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CustomCircularProgressBar(
        scale: progressBarScale,
        progress: downloadProgress.progress,
      ),

      /// error widget
      errorWidget: (context, url, error) => errorWidget ?? const Icon(
        Icons.error,
        color: AppColor.geeBung,
      ),
    );
  }
}
