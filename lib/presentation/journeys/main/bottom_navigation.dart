import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/presentation/journeys/main/bottom_navigation_items.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

import '../../logic/cubit/navigation/navigation_cubit.dart';

class BottomNavigation extends StatelessWidget {
  final UserType userType;

  const BottomNavigation({Key? key, required this.userType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
            // type: BottomNavigationBarType.fixed, //To stop animation
            backgroundColor: AppColor.geeBung,
            selectedItemColor: AppColor.geeBung,
            unselectedItemColor: AppColor.absoluteTransparentGeeBung,
            showUnselectedLabels: false,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),

            /// change current selected index
            currentIndex: state.index,

            /// on item pressed
            onTap: (index) => BlocProvider.of<NavigationCubit>(context)
                .bottomNavigationPressed(userType, index),

            /// add items to bottom nav
            items: _bottomNavListItems(userType, context));
      },
    );
  }

  /// return the bottom list item according to userType
  List<BottomNavigationBarItem> _bottomNavListItems(
      UserType userType, BuildContext context) {
    switch (userType) {

      ///==>client
      case UserType.client:
        return BottomNavigationItems().clientItems(context);

      /// broker or ambassador
      case UserType.broker:
      case UserType.ambassador:
        return BottomNavigationItems().broker(context);

      /// noUser, tour or default
      case UserType.unDefined:
      case UserType.tour:
      default:
        return BottomNavigationItems().clientItems(context);
    }
  }
}
