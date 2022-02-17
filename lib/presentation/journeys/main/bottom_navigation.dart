import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/cubit/navigation/navigation_cubit.dart';
import 'package:remax_mapstate/presentation/journeys/main/bottom_navigation_items.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

class BottomNavigation extends StatelessWidget {
  final UserType userType;

  const BottomNavigation({Key? key, required this.userType}) : super(key: key);


  /// return the bottom list item according to userType
  List<BottomNavigationBarItem> _bottomNavListItems(
      UserType userType, BuildContext context) {
    switch (userType) {
      case UserType.client:
        return BottomNavigationItems().clientItems(context);
      case UserType.broker:
        return BottomNavigationItems().broker(context);
      case UserType.tour:
        return BottomNavigationItems().clientItems(context);
      case UserType.other:
        return BottomNavigationItems().broker(context);
      case UserType.noUser:
        return BottomNavigationItems().clientItems(context);
      default:
        return BottomNavigationItems().clientItems(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            //To stop animation
            backgroundColor: AppColor.vulcan,
            selectedItemColor: Colors.white,
            showUnselectedLabels: false,
            currentIndex: state.index,
            onTap: (index) {
              /// To navigate if any user exists
              if (userType != UserType.noUser && userType != UserType.tour) {
                switch (index) {
                  case 0:
                    BlocProvider.of<NavigationCubit>(context).home(index);
                    break;
                  case 1:
                    if (userType == UserType.client ||
                        userType == UserType.tour) {
                      BlocProvider.of<NavigationCubit>(context)
                          .calculator(index);
                    } else {
                      BlocProvider.of<NavigationCubit>(context).support(index);
                    }
                    break;
                  case 2:
                    if (userType == UserType.client ||
                        userType == UserType.tour) {
                      BlocProvider.of<NavigationCubit>(context).favorite(index);
                    } else {
                      BlocProvider.of<NavigationCubit>(context)
                          .calculator(index);
                    }
                    break;
                  case 3:
                    BlocProvider.of<NavigationCubit>(context).profile(index);
                    break;
                }
              }
              else{
               throw UnimplementedError("You must handle No User and Tour User");
              }
            },

            /// add items to bottom nav
            items: _bottomNavListItems(userType, context));
      },
    );
  }
}
