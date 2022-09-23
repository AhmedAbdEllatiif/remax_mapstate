import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/data/tables/current_user_table.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/current_user.dart';
import 'package:remax_mapstate/presentation/journeys/calculator/calculator_screen.dart';
import 'package:remax_mapstate/presentation/journeys/favorite/favorite_screen.dart';
import 'package:remax_mapstate/presentation/journeys/not_user_login_first/not_a_user_login_first_screen.dart';
import 'package:remax_mapstate/presentation/journeys/profile/profile_screen.dart';
import 'package:remax_mapstate/presentation/journeys/team_support/team_support_screen.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:remax_mapstate/presentation/journeys/home/home_screen.dart';
import 'package:remax_mapstate/presentation/journeys/main/bottom_navigation.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

import '../../logic/cubit/current_user/current_user_cubit.dart';
import '../../logic/cubit/navigation/navigation_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late NavigationCubit navigationCubit;

  @override
  void initState() {
    super.initState();
    navigationCubit = getItInstance<NavigationCubit>();
  }

  @override
  void dispose() {
    navigationCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => navigationCubit,
      child: Scaffold(
        drawer: const NavigationDrawer(),

        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.fadeBlack,
          title: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) {
              return Text(state.title.t(context));
            },
          ),
        ),

        body: Stack(
          children: [
            BlocBuilder<NavigationCubit, NavigationState>(
              bloc: navigationCubit,
              builder: (context, state) {
                if (state is HomeState) {
                  return const HomeScreen();
                } else if (state is FavoriteState) {
                  return const FavoriteScreen();
                } else if (state is SupportState) {
                  return const TeamSupportScreen();
                } else if (state is ProfileState) {
                  return const ProfileScreen();
                } else if (state is CalculatorState) {
                  return const CalculatorScreen();
                } else if (state is NotAUser) {
                  return const NotAUserLoginFirstScreen();
                } else {
                  return const HomeScreen();
                }
              },
            ),

            // const MainAppBar(),
          ],
        ),

        // bottomNavigationBar
        bottomNavigationBar: BlocBuilder<CurrentUserCubit, CurrentUserTable>(
          builder: (context, currentUser) {
            return Theme(
                data:
                    Theme.of(context).copyWith(canvasColor: AppColor.fadeBlack),
                child: BottomNavigation(
                  userType:
                      CurrentUserEntity(currentUserStr: currentUser.currentUser)
                          .userType,
                ));
          },
        ),
      ),
    );
  }
}
