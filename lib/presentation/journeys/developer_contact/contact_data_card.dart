import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/domain/entities/contact_developer.dart';
import 'package:remax_mapstate/presentation/journeys/developer_contact/developer_data_item.dart';

import '../../../common/constants/sizes.dart';
import '../choose_broker/contact_info_widget.dart';

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
                dataKey: 'Name',
                value: contactDeveloperEntity.empSecondName != null
                    ? contactDeveloperEntity.empFirstName +
                        " " +
                        contactDeveloperEntity.empSecondName!
                    : contactDeveloperEntity.empFirstName,
                isLocation: false,
              ),

              const SizedBox(
                height: 15,
              ),


              /// Location
              //if(contactDeveloperEntity.developerLocation != null)
              const DeveloperDataItem(
                dataKey: 'Location',
                value: 'Get Directions',
                isLocation: true,
              ),

              const SizedBox(
                height: 30,
              ),

              /// contact info
              ContactInfoWidget(
                phoneNum: contactDeveloperEntity.empPhoneNum,
                whatsapp: contactDeveloperEntity.empPhoneNum,
              ),
            ],
          ),
        ));
  }
}
