import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/domain/entities/service_entity.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/enums/services.dart';
import '../../../themes/theme_color.dart';

class ServiceItemCard extends StatelessWidget {
  final ServiceEntity serviceEntity;

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
          CircleAvatar(
            maxRadius: Sizes.dimen_30.w,
            minRadius: Sizes.dimen_10.w,
            foregroundColor: AppColor.fadeBlack,
            backgroundColor: AppColor.fadeBlack,
            child: Padding(
              padding: const EdgeInsets.all(Sizes.dimen_12),
              child: Image.asset(
                serviceEntity.path,
                fit: BoxFit.cover,
                //color: AppColor.geeBung,
              ),
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
                .copyWith(color: AppColor.white,fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
