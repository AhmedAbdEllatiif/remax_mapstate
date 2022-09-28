import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import '../../../domain/entities/project_entity.dart';
import 'layout_item.dart';

class LayoutSection extends StatelessWidget {
  final List<UnitTypeSetEntity> unitTypeSets;

  const LayoutSection({Key? key, required this.unitTypeSets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: Sizes.dimen_5.h),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: Sizes.dimen_2.h),
          child: Text(
            TranslateConstants.layouts.t(context),
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: AppColor.absoluteTransparentGeeBung,
                ),
          ),
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: unitTypeSets.length,
            itemBuilder: (context, index) => ExpansionItem(
                  unitTypeSetEntity: unitTypeSets[index],
                )),
      ],
    );
  }
}

class ExpansionItem extends StatelessWidget {
  final UnitTypeSetEntity unitTypeSetEntity;

  const ExpansionItem({Key? key, required this.unitTypeSetEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: Text(unitTypeSetEntity.unitTypeTitle),
        collapsedTextColor: AppColor.geeBung,
        backgroundColor: AppColor.black,
        collapsedIconColor: AppColor.geeBung,
        collapsedBackgroundColor: AppColor.black,
        textColor: AppColor.absoluteTransparentGeeBung,
        iconColor: AppColor.absoluteTransparentGeeBung,
        childrenPadding: EdgeInsets.only(
            left: Sizes.dimen_4.w, right: Sizes.dimen_4.w, bottom: 10),
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
                /// area
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LayoutItem(
                        layoutKey: TranslateConstants.areaFrom.t(context),
                        value: unitTypeSetEntity.areaFrom,
                      ),
                      SizedBox(
                        height: Sizes.dimen_1.h,
                      ),
                      LayoutItem(
                        layoutKey: TranslateConstants.areaTo.t(context),
                        value: unitTypeSetEntity.areaTo,
                      ),
                    ],
                  ),
                ),

                /// prices
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LayoutItem(
                        layoutKey: TranslateConstants.priceFrom.t(context),
                        value: unitTypeSetEntity.formattedPriceFrom,
                      ),
                      SizedBox(
                        height: Sizes.dimen_1.h,
                      ),
                      LayoutItem(
                        layoutKey: TranslateConstants.priceTo.t(context),
                        value: unitTypeSetEntity.formattedPriceTo,
                      ),
                    ],
                  ),
                ),

                /// payment plan
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LayoutItem(
                        layoutKey: TranslateConstants.downPayment.t(context),
                        value: "${unitTypeSetEntity.percentage}%",
                      ),
                      SizedBox(
                        height: Sizes.dimen_1.h,
                      ),
                      LayoutItem(
                        layoutKey: TranslateConstants.numberOfYears.t(context),
                        value: unitTypeSetEntity.numberOfYears.toString(),
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
