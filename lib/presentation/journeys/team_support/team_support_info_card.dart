import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/cubit/team_support/team_support_cubit.dart';
import 'package:remax_mapstate/presentation/journeys/team_support/team_support_data_item.dart';



import '../../../common/constants/sizes.dart';
import '../../../domain/entities/team_support_entity.dart';
import '../../widgets/contact_info_widget.dart';


class TeamSupportCardInfo extends StatelessWidget {
  final TeamSupportEntity teamSupportEntity;

  const TeamSupportCardInfo({Key? key, required this.teamSupportEntity})
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
                value: teamSupportEntity.name
              ),

              const SizedBox(
                height: 15,
              ),



              SizedBox(
                height: Sizes.dimen_8.h,
              ),

              /// contact info
              ContactInfoWidget(
                phoneNum: teamSupportEntity.phoneNum,
                whatsapp: teamSupportEntity.whatsappNum,
                onWhatsappPressed: () {
                  context.read<TeamSupportCubit>().openWhatsApp(
                    welcomeText:
                    TranslateConstants.welcomeWhatsappText.t(context),
                    text: TranslateConstants.defaultBrokerWhatsappText
                        .t(context),
                  );
                },
                onCallPressed: () {
                  context.read<TeamSupportCubit>().makePhoneCall();
                },
              ),
            ],
          ),
        ));
  }
}
