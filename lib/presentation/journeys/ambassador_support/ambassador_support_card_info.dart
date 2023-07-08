import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/constants/translate_constatns.dart';
import '../../../domain/entities/ambassador_support_entity.dart';
import '../../widgets/contact_info_widget.dart';
import '../team_support/team_support_data_item.dart';

class AmbassadorSupportCardInfo extends StatelessWidget {
  final AmbassadorSupportEntity ambassadorSupportEntity;

  const AmbassadorSupportCardInfo({Key? key, required this.ambassadorSupportEntity})
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
              /// name
              TeamSupportDataItem(
                  dataKey: TranslateConstants.contactWith.t(context),
                  value: ambassadorSupportEntity.name),

              /// spacing
              SizedBox(
                height: Sizes.dimen_8.h,
              ),

              /// contact info
              ContactInfoWidget(
                phoneNum: ambassadorSupportEntity.phoneNum,
                whatsapp: ambassadorSupportEntity.whatsappNum,
              ),
            ],
          ),
        ));
  }
}
