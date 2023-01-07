import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/params/contact_developer.dart';
import 'package:remax_mapstate/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/constants/translate_constatns.dart';
import '../../../router/route_hepler.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_button.dart';
import '../choose_broker/arguments/choose_broker_argument.dart';

class ButtonSection extends StatelessWidget {
  final String developerId;

  const ButtonSection({Key? key, required this.developerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizedUserCubit, AuthorizedUserState>(
      builder: (context, state) {
        final userType = state.currentUserType;

        ///  tour or noUser
        if (userType == UserType.tour || userType == UserType.unDefined) {
          return Container(
            color: AppColor.absoluteTransparentGeeBung,
            padding: EdgeInsets.symmetric(
              vertical: Sizes.dimen_5.h,
              horizontal: Sizes.dimen_16.w,
            ),
            child: AppButtonGradient(
              text: TranslateConstants.login.t(context).toUpperCase(),
              onPressed: () {
                RouteHelper().chooseUserTypeScreen(context, isClearStack: true);
              },
            ),
          );
        }

        /// client
        if (userType == UserType.client) {
          return Container(
            color: AppColor.absoluteTransparentGeeBung,
            padding: EdgeInsets.symmetric(vertical: Sizes.dimen_5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppButtonGradient(
                  text:
                      TranslateConstants.requestACall.t(context).toUpperCase(),
                  onPressed: () {},
                ),
                AppButtonGradient(
                  text: TranslateConstants.selectYourBroker
                      .t(context)
                      .toUpperCase(),
                  reverseGradient: true,
                  onPressed: () => RouteHelper().chooseBrokerScreen(
                    context,
                    chooseBrokerArgument:
                        const ChooseBrokerArgument(areaId: "0"),
                  ),
                ),
              ],
            ),
          );
        }

        /// broker or ambassador
        if (userType == UserType.broker || userType == UserType.ambassador) {
          return Container(
            color: AppColor.absoluteTransparentGeeBung,
            padding: EdgeInsets.symmetric(
              vertical: Sizes.dimen_5.h,
              horizontal: Sizes.dimen_16.w,
            ),
            child: AppButtonGradient(
              text: TranslateConstants.contactWithDeveloper
                  .t(context)
                  .toUpperCase(),
              onPressed: () {
                final contactDeveloperParam = ContactDeveloperParam(
                    developerId: developerId, name: "Mountain View");
                RouteHelper().contactDeveloper(context,
                    contactDeveloperParam: contactDeveloperParam);
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
