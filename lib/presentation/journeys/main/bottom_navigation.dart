import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/cubit/navigation/navigation_cubit.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

class BottomNavigation extends StatelessWidget {
  final UserType userType;

  const BottomNavigation({Key? key, required this.userType}) : super(key: key);

  int _getCurrentSelected(NavigationState state) {
    if (state is HomeState) {
      return 0;
    } else if (state is SupportState) {
      return 1;
    } else if (state is FavoriteState) {
      return 2;
    } else if (state is ProfileState) {
      return 3;
    } else if (state is CalculatorState) {
      return 2;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    /* final List<BottomNavigationBarItem> bottomItems =  [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home_outlined),
        label: TranslateConstants.home.t(context),
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
          icon: const Icon(Icons.support_outlined),
          label:  TranslateConstants.support.t(context),
          backgroundColor: Colors.red),
      */ /* BottomNavigationBarItem(
        icon: Icon(Icons.calculate_outlined),
        label: 'Calculator',
        backgroundColor: Colors.blue),*/ /*
      BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_border_outlined),
          label: TranslateConstants.favorite.t(context),
          backgroundColor: Colors.blue),
      BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          label: TranslateConstants.profile.t(context),
          backgroundColor: Colors.orange),
    ];*/
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
                BlocProvider.of<NavigationCubit>(context).home();
                break;
              case 1:
                BlocProvider.of<NavigationCubit>(context).support();
                break;
              case 2:
                if (userType == UserType.client || userType == UserType.tour) {
                  BlocProvider.of<NavigationCubit>(context).favorite();
                }else{
                  BlocProvider.of<NavigationCubit>(context).calculator();
                }
                break;
              case 3:
                BlocProvider.of<NavigationCubit>(context).profile();
                break;
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: TranslateConstants.home.t(context),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
                icon: const Icon(Icons.support_outlined),
                label: TranslateConstants.support.t(context),
                backgroundColor: Colors.red),

            // show calculator if user is not client or tour
            if (userType != UserType.client && userType != UserType.tour)
              const BottomNavigationBarItem(
                  icon: Icon(Icons.calculate_outlined),
                  label: 'Calculator',
                  backgroundColor: Colors.blue),

            // show favorite if user is client or tour
            if (userType == UserType.client || userType == UserType.tour)
              BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite_border_outlined),
                  label: TranslateConstants.favorite.t(context),
                  backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline),
                label: TranslateConstants.profile.t(context),
                backgroundColor: Colors.orange),
          ],
        );
      },
    );
  }
}
