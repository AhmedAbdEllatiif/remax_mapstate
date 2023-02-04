import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/widgets/cached_image_widget.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../domain/entities/service_type_entity.dart';
import '../../../themes/theme_color.dart';

class ServiceItemCard extends StatelessWidget {
  final ServiceTypeEntity serviceEntity;

  const ServiceItemCard({
    Key? key,
    required this.serviceEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Sizes.dimen_10.w),
      child: Column(
        children: [
          // CircleAvatar(
          //   maxRadius: Sizes.dimen_40.w,
          //   minRadius: Sizes.dimen_10.w,
          //   foregroundColor: AppColor.fadeBlack,
          //   backgroundColor: AppColor.fadeBlack,
          //   child: Padding(
          //     padding: const EdgeInsets.all(Sizes.dimen_12),
          //     child: ,Image.asset(
          //       serviceEntity.path,
          //       fit: BoxFit.cover,
          //       //color: AppColor.geeBung,
          //     ),
          //   ),
          // ),

          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                color: AppColor.fadeBlack, shape: BoxShape.circle),
            child: CachedImageWidget(
              imageUrl: serviceEntity.icon,
              height: Sizes.dimen_48.w,
              width: Sizes.dimen_48.w,
              isCircle: false,
              progressBarScale: 0.5,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            serviceEntity.name.toUpperCase(),
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: AppColor.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
