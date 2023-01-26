import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/data/params/make_call_params.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/logic/bloc/launch_apps/launch_apps_bloc.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../common/functions/show_snack_bar.dart';
import '../../data/params/whatsapp_params.dart';

/// This Widget for contact info (Whatsapp, PhoneCall)
class ContactInfoWidget extends StatefulWidget {
  final String? whatsapp;
  final String phoneNum;
  final Function()? onWhatsappPressed;
  final Function()? onCallPressed;
  final LaunchAppsBloc? launchAppsBloc;
  final Color? whatsappIconColor;

  const ContactInfoWidget({
    Key? key,
    this.whatsapp,
    required this.phoneNum,
    this.onWhatsappPressed,
    this.onCallPressed,
    this.launchAppsBloc,
    this.whatsappIconColor,
  }) : super(key: key);

  @override
  State<ContactInfoWidget> createState() => _ContactInfoWidgetState();
}

class _ContactInfoWidgetState extends State<ContactInfoWidget> {
  late final LaunchAppsBloc _launchAppsBloc;

  @override
  void initState() {
    super.initState();
    _launchAppsBloc = widget.launchAppsBloc ?? getItInstance<LaunchAppsBloc>();
  }

  @override
  void dispose() {
    if (widget.launchAppsBloc == null) _launchAppsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _launchAppsBloc,
      child: BlocConsumer<LaunchAppsBloc, LaunchAppsState>(
        bloc: _launchAppsBloc,
        listener: (context, state) {
          // error make a call
          if (state is ErrorWhileMakeACall) {
            showSnackBar(
              context,
              message: TranslateConstants.somethingWentWrong.t(context),
            );
          }

          // error open whatsapp
          if (state is ErrorWhileOpenWhatsApp) {
            showSnackBar(
              context,
              message: TranslateConstants.somethingWentWrong.t(context),
            );
          }
        },
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// whatsapp
              if (widget.whatsapp != null)
                Column(
                  children: [
                    Text(
                      TranslateConstants.whatsapp.t(context),
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: AppColor.black),
                    ),
                    state is LoadingToLaunchWhatsapp
                        ? const Center(child: LoadingWidget())
                        : IconButton(
                            iconSize: Sizes.dimen_14.h,
                            splashColor: AppColor.black,
                            splashRadius: Sizes.dimen_22.w,
                            icon: Image.asset(
                              AssetsConstants.whatsapp,
                              fit: BoxFit.cover,
                              color: widget.whatsappIconColor ?? AppColor.green,
                            ),
                            onPressed:
                                widget.onWhatsappPressed ?? _openWhatsapp,
                          ),
                  ],
                ),

              /// phone call
              Column(
                children: [
                  Text(
                    TranslateConstants.friendlyPhoneCall.t(context),
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: AppColor.black),
                  ),
                  state is LoadingToMakeACall
                      ? const Center(child: LoadingWidget())
                      : IconButton(
                          iconSize: Sizes.dimen_14.h,
                          splashColor: AppColor.black,
                          splashRadius: Sizes.dimen_22.w,
                          icon: Image.asset(
                            AssetsConstants.phoneCall,
                            fit: BoxFit.cover,
                            //color: AppColor.royalBlue,
                          ),
                          onPressed: widget.onCallPressed ?? _makePhoneCall,
                        ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  /// to make a phone call
  void _makePhoneCall() {
    _launchAppsBloc.add(MakeACallEvent(
        makeCallParams: MakeCallParams(
      phoneNum: widget.phoneNum,
    )));
  }

  /// to open whatsapp
  void _openWhatsapp() {
    final whatsappParams = WhatsappParams(
      num: widget.phoneNum,
      text: TranslateConstants.welcomeWhatsappText.t(context),
    );

    _launchAppsBloc.add(OpenWhatsAppEvent(whatsappParams: whatsappParams));
  }
}
