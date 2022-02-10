import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

class LayoutSection extends StatelessWidget {
  const LayoutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(top: 10),),
        Text(TranslateConstants.layouts.t(context),
          style: Theme.of(context).textTheme.violetSubTitle2,),

        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 7,
            itemBuilder: (context,index) => ExpansionItem(title: 'Bed Room',description: '3 bed rooms',)
        ),
      ],
    );
  }
}



class ExpansionItem extends StatelessWidget {
  final String title;
  final String description;

  const ExpansionItem(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent,),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.dimen_16.w)
        ),
        child: ExpansionTile(
          title: Text(title),
          collapsedTextColor: AppColor.vulcan,
          backgroundColor: Colors.white,
          collapsedIconColor: AppColor.vulcan,
          collapsedBackgroundColor:  Colors.white,
          textColor: AppColor.royalBlue,
          iconColor: AppColor.royalBlue,
          childrenPadding: EdgeInsets.only(left: 50,right: 50,bottom: 10),
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
                children: [
                  Column(
                    children: [
                      Text(
                        description,
                        style: TextStyle(
                            color: AppColor.vulcan, backgroundColor: Colors.white),
                      ),
                    ],
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}