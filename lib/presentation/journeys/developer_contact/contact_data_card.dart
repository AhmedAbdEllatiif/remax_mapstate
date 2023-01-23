import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/contact_developer.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/presentation/journeys/developer_contact/developer_data_item.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/sizes.dart';
import '../../logic/cubit/developer_contact/developer_contact_cubit.dart';
import '../../widgets/contact_info_widget.dart';
import 'location_data_item.dart';

class ContactDataCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final String _name = _buildContactName();

    return Card(
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
                value: _name,
              ),

              const SizedBox(
                height: 15,
              ),

              /// Location
              if (developerContactEntity.firstName != null)
                LocationDataItem(
                  dataKey: developerName,
                  value: TranslateConstants.getDirections.t(context),
                  locationEntity: locationEntity,
                ),

              SizedBox(
                height: Sizes.dimen_8.h,
              ),

              /// contact info
              ContactInfoWidget(
                phoneNum: developerContactEntity.phone,
                whatsapp: developerContactEntity.phone,
                onWhatsappPressed: () {
                  context.read<DeveloperContactCubit>().openWhatsApp(
                        welcomeText:
                            TranslateConstants.welcomeWhatsappText.t(context),
                        text: TranslateConstants.defaultBrokerWhatsappText
                            .t(context),
                      );
                },
                onCallPressed: () {
                  context.read<DeveloperContactCubit>().makePhoneCall();
                },
              ),
            ],
          ),
        ));
  }

  String _buildContactName() {
    final String firstName =
        developerContactEntity.firstName != AppUtils.undefined
            ? developerContactEntity.firstName
            : "";
    final String lastName =
    developerContactEntity.lastName != AppUtils.undefined
        ? developerContactEntity.lastName
        : "";

    return firstName + " " + lastName;
  }
}
