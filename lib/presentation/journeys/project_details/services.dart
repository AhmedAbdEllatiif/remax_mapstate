import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/enums/services.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

class ServicesSection extends StatelessWidget {
  final List<String> services;

  const ServicesSection({Key? key, required this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TranslateConstants.services.t(context),
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: AppColor.absoluteTransparentGeeBung),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: ScreenUtil.screenWidth,
          height: ScreenUtil.screenHeight * .11,
          constraints: BoxConstraints(
              minHeight: ScreenUtil.screenHeight * 0.11,
              maxHeight: ScreenUtil.screenHeight * .15),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: services.length,
              itemBuilder: (context, index) => ServiceItemCard(
                    projectServices: ProjectServices.gym,
                    serviceName: services[index],
                  )),
        ),
      ],
    );
  }
}

class ServiceItemCard extends StatelessWidget {
  final ProjectServices projectServices;
  final String serviceName;

  const ServiceItemCard({
    Key? key,
    required this.projectServices,
    required this.serviceName,
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
            foregroundColor: AppColor.geeBung,
            backgroundColor: AppColor.geeBung,
            child: Padding(
              padding: const EdgeInsets.all(Sizes.dimen_12),
              child: Image.asset(
                AssetsConstants.gymIcon,
                fit: BoxFit.cover,
                color: AppColor.black,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            serviceName.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: AppColor.geeBung),
          )
        ],
      ),
    );
  }
}
