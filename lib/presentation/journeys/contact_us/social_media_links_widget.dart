import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/widgets/social_media_item.dart';

import '../../../common/constants/assets_constants.dart';
import '../../../common/constants/translate_constatns.dart';
import '../../themes/theme_color.dart';

class SocialMediaLinksWidget extends StatelessWidget {
  const SocialMediaLinksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SocialMediaItem(
          text: TranslateConstants.whatsapp.t(context),
          img: AssetsConstants.whatsapp,
          iconColor: AppColor.whatsappGreen,
          onPressed: () {},
        ),


        const SizedBox(width: 20),


        SocialMediaItem(
          text: TranslateConstants.facebook.t(context),
          img: AssetsConstants.facebook,
          iconColor: AppColor.royalBlue,
          onPressed: () {},
        ),
      ],
    );
  }
}
