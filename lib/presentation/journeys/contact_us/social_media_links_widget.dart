import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';
import 'package:remax_mapstate/presentation/widgets/social_media_item.dart';

import '../../../common/constants/assets_constants.dart';
import '../../../common/constants/translate_constatns.dart';
import '../../logic/bloc/launch_apps/launch_apps_bloc.dart';
import '../../themes/theme_color.dart';

class SocialMediaLinksWidget extends StatelessWidget {
  final LaunchAppsBloc launchAppsBloc;
  final Function() onWhatsappPressed;
  final Function() onFacebookPressed;

  const SocialMediaLinksWidget({
    Key? key,
    required this.launchAppsBloc,
    required this.onWhatsappPressed,
    required this.onFacebookPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchAppsBloc, LaunchAppsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // whatsapp
            state is LoadingToLaunchWhatsapp
                ? const Center(child: LoadingWidget())
                : SocialMediaItem(
                    text: TranslateConstants.whatsapp.t(context),
                    img: AssetsConstants.whatsapp,
                    iconColor: AppColor.whatsappGreen,
                    onPressed: onWhatsappPressed,
                  ),

            // space
            const SizedBox(width: 20),

            // facebook
            state is LoadingToOpenFacebook
                ? const Center(child: LoadingWidget())
                : SocialMediaItem(
                    text: TranslateConstants.facebook.t(context),
                    img: AssetsConstants.facebook,
                    iconColor: AppColor.royalBlue,
                    onPressed: onFacebookPressed,
                  ),
          ],
        );
      },
    );
  }
}
