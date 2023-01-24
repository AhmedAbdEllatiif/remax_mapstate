import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/data/params/make_call_params.dart';
import 'package:remax_mapstate/data/params/whatsapp_params.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/presentation/journeys/developer_contact/developer_data_item.dart';

import '../../../common/constants/sizes.dart';
import '../../../di/git_it.dart';
import '../../logic/bloc/launch_apps/launch_apps_bloc.dart';
import '../../widgets/contact_info_widget.dart';
import 'location_data_item.dart';

class ContactDataCard extends StatefulWidget {
  final DeveloperContactEntity developerContactEntity;
  final String developerName;
  final LocationEntity locationEntity;

  const ContactDataCard({
    Key? key,
    required this.developerContactEntity,
    required this.developerName,
    required this.locationEntity,
  }) : super(key: key);

  @override
  State<ContactDataCard> createState() => _ContactDataCardState();
}

class _ContactDataCardState extends State<ContactDataCard> {
  /// LaunchAppsBloc
  late final LaunchAppsBloc _launchAppsBloc;

  @override
  void initState() {
    super.initState();
    _launchAppsBloc = getItInstance<LaunchAppsBloc>();
  }

  @override
  void dispose() {
    _launchAppsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _launchAppsBloc,
      child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// firstName
                DeveloperDataItem(
                  dataKey: TranslateConstants.contactWith.t(context),
                  value: widget.developerContactEntity.fullName,
                ),

                const SizedBox(
                  height: 15,
                ),

                /// Location
                if (widget.developerContactEntity.firstName != null)
                  LocationDataItem(
                    dataKey: widget.developerName,
                    value: TranslateConstants.getDirections.t(context),
                    locationEntity: widget.locationEntity,
                    locationName: widget.developerName,
                    launchAppsBloc: _launchAppsBloc,
                  ),

                SizedBox(
                  height: Sizes.dimen_8.h,
                ),

                /// contact info
                ContactInfoWidget(
                  phoneNum: widget.developerContactEntity.phone,
                  whatsapp: widget.developerContactEntity.phone,
                  launchAppsBloc: _launchAppsBloc,
                  onWhatsappPressed: () => _openWhatsapp(),
                  onCallPressed: () => _makeACall(),
                ),
              ],
            ),
          )),
    );
  }

  /// to make a call
  void _makeACall() {
    final makeACallParams = MakeCallParams(
      phoneNum: widget.developerContactEntity.phone,
    );

    _launchAppsBloc.add(MakeACallEvent(makeCallParams: makeACallParams));
  }

  /// to open whatsapp
  void _openWhatsapp() {
    final whatsappParams = WhatsappParams(
      num: widget.developerContactEntity.phone,
      text: TranslateConstants.welcomeWhatsappText.t(context),
    );

    _launchAppsBloc.add(OpenWhatsAppEvent(whatsappParams: whatsappParams));
  }
}
