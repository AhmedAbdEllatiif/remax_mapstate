import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';


/// This Widget for contact info (Whatsapp, PhoneCall)
class ContactInfoWidget extends StatelessWidget {
  final String? whatsapp;
  final String phoneNum;
  final Function() onWhatsappPressed;
  final Function() onCallPressed;

  const ContactInfoWidget(
      {Key? key, this.whatsapp = null, required this.phoneNum, required this.onWhatsappPressed, required this.onCallPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /// whatsapp
        if (whatsapp != null)
          Column(
            children: [
              Text(
                TranslateConstants.whatsapp.t(context),
                style: Theme.of(context).textTheme.caption!.copyWith(
                    color: AppColor.absoluteTransparentGeeBung
                ),
              ),
              IconButton(
                iconSize: Sizes.dimen_14.h ,
                splashColor: AppColor.black,
                splashRadius:Sizes.dimen_22.w,
                icon: Image.asset(
                  AssetsConstants.whatsapp,
                  fit: BoxFit.cover,
                  //color: AppColor.royalBlue,
                ), onPressed: onWhatsappPressed,
              ),
            ],
          ),

        /// phone call
        Column(
          children: [
            Text(
              TranslateConstants.friendlyPhoneCall.t(context),
              style: Theme.of(context).textTheme.caption!.copyWith(
                  color: AppColor.absoluteTransparentGeeBung
              ),
            ),

            IconButton(
              iconSize: Sizes.dimen_14.h ,
              splashColor: AppColor.black,
              splashRadius:Sizes.dimen_22.w,
              icon: Image.asset(
                AssetsConstants.phoneCall,
                fit: BoxFit.cover,
                //color: AppColor.royalBlue,
              ), onPressed: onCallPressed,
            ),

          ],
        ),
      ],
    );
  }
}

