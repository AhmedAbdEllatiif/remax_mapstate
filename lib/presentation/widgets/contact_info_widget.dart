import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
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
                style: Theme.of(context).textTheme.geryCaption,
              ),
              GestureDetector(
                onTap: onWhatsappPressed,
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

        /// phone call
        Column(
          children: [
            Text(
              TranslateConstants.friendlyPhoneCall.t(context),
              style: Theme.of(context).textTheme.geryCaption,
            ),
            GestureDetector(
              onTap: onCallPressed,
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

