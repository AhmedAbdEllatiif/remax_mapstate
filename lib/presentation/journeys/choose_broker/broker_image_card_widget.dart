import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:remax_mapstate/common/constants/argument_constants.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';


class BrokerImageCardWidget extends StatelessWidget {
  final String posterPath;

  const BrokerImageCardWidget({
    Key? key,
    required this.posterPath,
  }) : super(key: key);


/**/
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32.0,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
        child: Image.asset(
          posterPath,
          fit: BoxFit.cover,
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
