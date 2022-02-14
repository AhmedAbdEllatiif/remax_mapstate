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
            //onTap: (index) => setState(() => currentIndex = index),
            onTap: (index) {
              switch (index) {
                case 0:
                  BlocProvider.of<NavigationCubit>(context).home(index);
                  break;
                case 1:
                  if (userType == UserType.client ||
                      userType == UserType.tour) {
                    BlocProvider.of<NavigationCubit>(context).calculator(index);
                  } else {
                    BlocProvider.of<NavigationCubit>(context).support(index);
                  }
                  break;
                case 2:
                  if (userType == UserType.client ||
                      userType == UserType.tour) {
                    BlocProvider.of<NavigationCubit>(context).favorite(index);
                  } else {
                    BlocProvider.of<NavigationCubit>(context).calculator(index);
                  }
                  break;
                case 3:
                  BlocProvider.of<NavigationCubit>(context).profile(index);
                  break;
              }
            },
            items: userType == UserType.client
                ? BottomNavigationItems().clientItems(context)
                : BottomNavigationItems().broker(context));
      },
    );
  }
}
