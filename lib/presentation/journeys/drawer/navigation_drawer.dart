import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/language_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/cubit/current_user/current_user_cubit.dart';
import 'package:remax_mapstate/presentation/cubit/language/language_cubit.dart';
import 'package:remax_mapstate/presentation/journeys/drawer/navgation_expanded_list_tile.dart';
import 'package:remax_mapstate/presentation/journeys/drawer/navigation_list_item.dart';
import 'package:remax_mapstate/presentation/widgets/logo.dart';
import 'package:remax_mapstate/router/route_hepler.dart';

import '../../cubit/auto_login/auto_login_cubit.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            color: Theme.of(context).primaryColor.withOpacity(0.9),
          )
        ],
      ),
      width: Sizes.dimen_300.w,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// logo
            Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_8.h,
                bottom: Sizes.dimen_18.h,
                left: Sizes.dimen_8.w,
                right: Sizes.dimen_8.w,
              ),
              child: Logo(
                height: Sizes.dimen_20.h,
              ),
            ),

            /// Okay
            NavigationListItem(
              title: TranslateConstants.okay.t(context),
              onPressed: () {},
            ),


            /// Change language
            NavigationExpandedListItem(
              title: TranslateConstants.language.t(context),
              onPressed: (index) => _onLanguageSelected(index,context),
              children: LanguageConstants.supportedLanguages
                  .map((e) => e.value)
                  .toList(),
            ),


            /// Okay
            NavigationListItem(
              title: TranslateConstants.okay.t(context),
              onPressed: () {
                // to close the drawer
                Navigator.of(context).pop();
              },
            ),

            /// About
            NavigationListItem(
              title: TranslateConstants.about.t(context),
              onPressed: () {
                // to close the drawer
                Navigator.of(context).pop();

                _showDialog(context);
              },
            ),


            /// Logout
            NavigationListItem(
              title: TranslateConstants.logout.t(context),
              onPressed: () async {

                /// clear current user data
                await _clearCurrentUser(context);

                /// navigate to choose userScreen
                _navigateToChooseUserScreen(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// To remove currentUser and autoLogin
  Future<void> _clearCurrentUser(BuildContext context) async {
    /// remove current user
    await BlocProvider.of<CurrentUserCubit>(context).removeUser();
    /// remove auto login
    await context.read<AutoLoginCubit>().delete();
  }

  /// To navigate to chooseUserScreen
  void _navigateToChooseUserScreen(BuildContext context){
    RouteHelper().chooseUserTypeScreen(context, isClearStack: true);
  }



  void _onLanguageSelected(int index, BuildContext context) {
    BlocProvider.of<LanguageCubit>(context).toggleLanguage(
      LanguageConstants.supportedLanguages[index],
    );
  }

  void _showDialog(BuildContext context) {
    /*showDialog(
      context: context,
      builder: (context) {
        return AppDialog(
            title: TranslateConstants.about.t(context),
            description: TranslateConstants.aboutDescription.t(context),
            buttonText: TranslateConstants.okay.t(context),
            image: Image.asset(AssetConstants.tmdb_logo,height: Sizes.dimen_32.h,),
        );
      },
    );*/
  }
}
