import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

class ContactInfoCard extends StatelessWidget {

  final String whatsapp;
  final String phoneNum;

  const ContactInfoCard({Key? key, required this.whatsapp, required this.phoneNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        Column(
          children: [
            Text(
              "Whatsapp",
              style: Theme.of(context).textTheme.geryCaption,
            ),
            GestureDetector(
              onTap: (){},
              child: Container(
                height: Sizes.dimen_30.w,
                margin: EdgeInsets.only(top: Sizes.dimen_10.w),
                child: Image.asset(
                  AssetsConstants.whatsapp,
                  fit: BoxFit.cover,
                ),
              ),
            ),

          ],
        ),

        Column(
          children: [
            Text(
              "Lovely Phone call",
              style: Theme.of(context).textTheme.geryCaption,
            ),
            GestureDetector(
              onTap: (){},
              child: Container(
                height: Sizes.dimen_30.w,
                margin: EdgeInsets.only(top: Sizes.dimen_10.w),
                child: Image.asset(
                  AssetsConstants.phoneCall,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),

      ],
    );
  }
}
