import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/contact_developer.dart';
import 'package:remax_mapstate/presentation/journeys/developer_contact/developer_data_item.dart';

import '../../../common/constants/sizes.dart';
import '../../cubit/developer_contact/developer_contact_cubit.dart';
import '../../widgets/contact_info_widget.dart';
import 'location_data_item.dart';

class ContactDataCard extends StatelessWidget {
  final ContactDeveloperEntity contactDeveloperEntity;

  const ContactDataCard({Key? key, required this.contactDeveloperEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                value: contactDeveloperEntity.empSecondName != null
                    ? contactDeveloperEntity.empFirstName +
                        " " +
                        contactDeveloperEntity.empSecondName!
                    : contactDeveloperEntity.empFirstName,
              ),

              const SizedBox(
                height: 15,
              ),

              /// Location
              //if(contactDeveloperEntity.developerLocation != null)
              LocationDataItem(
                dataKey: contactDeveloperEntity.developerName,
                value: TranslateConstants.getDirections.t(context),
              ),

              const SizedBox(
                height: 30,
              ),

              /// contact info
              ContactInfoWidget(
                phoneNum: contactDeveloperEntity.empPhoneNum,
                whatsapp: contactDeveloperEntity.empPhoneNum,
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
}
