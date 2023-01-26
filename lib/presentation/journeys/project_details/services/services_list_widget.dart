import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/enums/services.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/domain/entities/service_entity.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/services/service_item.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

import '../section_title_text.dart';

class ServicesListWidget extends StatelessWidget {
  final List<ServiceEntity> services;

  const ServicesListWidget({Key? key, required this.services})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleText(
          text: TranslateConstants.services.t(context),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: ScreenUtil.screenWidth,
          //height: ScreenUtil.screenHeight * .11,
          constraints: BoxConstraints(
              minHeight: ScreenUtil.screenHeight * 0.11,
              maxHeight: ScreenUtil.screenHeight * .15),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: services.length,
              itemBuilder: (context, index) => ServiceItemCard(
                    serviceEntity: services[index],
                  )),
        ),
      ],
    );
  }
}
