import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import '../../../domain/entities/project_entity.dart';

class LayoutSection extends StatelessWidget {
  final List<UnitTypeSetEntity> unitTypeSets;

  const LayoutSection({Key? key, required this.unitTypeSets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
        ),
        Text(
          TranslateConstants.layouts.t(context),
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: AppColor.absoluteTransparentGeeBung,
              ),
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: unitTypeSets.length,
            itemBuilder: (context, index) => ExpansionItem(
                  title: unitTypeSets[index].name,
                  finishingType: unitTypeSets[index].finishingType,
              areaFrom: unitTypeSets[index].areaFrom,
              layout: unitTypeSets[index].layout,
                )),
      ],
    );
  }
}

class ExpansionItem extends StatelessWidget {
  final String title;
  final String finishingType;
  final String areaFrom;
  final String layout;

  const ExpansionItem(
      {Key? key,
      required this.title,
      required this.finishingType,
      required this.areaFrom,
      required this.layout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: Text(title),
        collapsedTextColor: AppColor.geeBung,
        backgroundColor: AppColor.black,
        collapsedIconColor: AppColor.geeBung,
        collapsedBackgroundColor: AppColor.black,
        textColor: AppColor.absoluteTransparentGeeBung,
        iconColor: AppColor.absoluteTransparentGeeBung,
        childrenPadding: EdgeInsets.only(left: Sizes.dimen_4.w, right: Sizes.dimen_4.w, bottom: 10),
        children: [
          Container(
            // margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
            padding: EdgeInsets.all(10),
            /*decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: AppColor.violet),
              //border: Border.symmetric(vertical: BorderSide(color: AppColors.primaryColor)),
            ),*/
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


                // finishing type
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Finishing Type",
                        overflow: TextOverflow.ellipsis,
                        style:  TextStyle(
                          color: AppColor.absoluteTransparentGeeBung,
                        ),
                      ),
                      Text(
                        finishingType,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColor.fadeGeeBung,
                        ),
                      ),
                    ],
                  ),
                ),

                // area from
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Area From",
                        overflow: TextOverflow.ellipsis,
                        style:  TextStyle(
                          color: AppColor.absoluteTransparentGeeBung,
                        ),
                      ),
                      Text(
                        areaFrom,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColor.fadeGeeBung,
                        ),
                      ),
                    ],
                  ),
                ),



                // layout
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Layout",
                        overflow: TextOverflow.ellipsis,
                        style:  TextStyle(
                          color: AppColor.absoluteTransparentGeeBung,
                        ),
                      ),
                      Text(
                       layout,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColor.fadeGeeBung,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
