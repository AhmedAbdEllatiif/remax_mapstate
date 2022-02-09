import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: AppColor.vulcan),
                //border: Border.symmetric(vertical: BorderSide(color: AppColors.primaryColor)),
              ),
              child: Expanded(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          description,
                          style: TextStyle(
                              color: AppColor.royalBlue, backgroundColor: Colors.white),
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
