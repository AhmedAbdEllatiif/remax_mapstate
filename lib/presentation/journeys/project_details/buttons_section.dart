import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/params/contact_developer.dart';
import 'package:remax_mapstate/presentation/cubit/current_user/current_user_cubit.dart';
import 'package:remax_mapstate/presentation/cubit/current_user/current_user_cubit.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/constants/translate_constatns.dart';
import '../../../data/tables/current_user_table.dart';
import '../../../domain/entities/current_user.dart';
import '../../../router/route_hepler.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_button.dart';
import '../choose_broker/arguments/choose_broker_argument.dart';

class ButtonSection extends StatelessWidget {

  final int developerId;

  const ButtonSection({Key? key, required this.developerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserTable>(
      builder: (context, currentUserTable) {
        final currentUser = currentUserType(currentUserTable);

        /// if client, tour or noUser
        if(currentUser == UserType.client || currentUser == UserType.tour || currentUser == UserType.noUser){
          return Container(
            color: AppColor.vulcan,
            padding: EdgeInsets.symmetric(vertical: Sizes.dimen_5.h),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppButtonGradient(
                  text: TranslateConstants.submitInquiry.t(context).toUpperCase(),
                  onPressed: () {},
                ),
                AppButtonGradient(
                  text: TranslateConstants.selectYourBroker.t(context).toUpperCase(),
                  reverseGradient: true,
                  onPressed: () =>
                      RouteHelper().chooseBrokerScreen(
                        context,
                        chooseBrokerArgument:
                        const ChooseBrokerArgument(areaId: "0"),
                      ),
                ),
              ],
            ),
          );
        }

        /// if broker or ambassador
        if(currentUser == UserType.broker || currentUser == UserType.ambassador){
          return Container(
            color: AppColor.vulcan,
            padding: EdgeInsets.symmetric(vertical: Sizes.dimen_5.h,horizontal: Sizes.dimen_16.w,),
            child:AppButtonGradient(
              text: TranslateConstants.contactWithDeveloper.t(context).toUpperCase(),
              onPressed: () {
                final contactDeveloperParam = ContactDeveloperParam(developerId: developerId,name: "Mountain View");
                RouteHelper().contactDeveloper(context, contactDeveloperParam: contactDeveloperParam);
              },
            ),
          );
        }

        return const SizedBox.shrink();

      },
    );
  }

  UserType currentUserType(CurrentUserTable currentUserTable){
   return CurrentUserEntity(currentUserStr: currentUserTable.currentUser).userType;
  }
}



