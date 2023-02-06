import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/users/user_entity.dart';
import 'package:remax_mapstate/presentation/journeys/calculator/calculator_screen.dart';
import 'package:remax_mapstate/presentation/journeys/favorite/favorite_screen.dart';
import 'package:remax_mapstate/presentation/journeys/not_user_login_first/not_a_user_login_first_screen.dart';
import 'package:remax_mapstate/presentation/journeys/profile/profile_screen.dart';
import 'package:remax_mapstate/presentation/journeys/team_support/team_support_screen.dart';
import 'package:remax_mapstate/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:remax_mapstate/presentation/journeys/home/home_screen.dart';
import 'package:remax_mapstate/presentation/journeys/main/bottom_navigation.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/router/route_hepler.dart';

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
          title: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) {
              return Text(state.title.t(context));
            },
          ),
          actions: [
            // filter icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, state) {
                  // if(state is ProfileState){
                  //   return IconButton(
                  //     onPressed: () {
                  //       throw UnimplementedError("Add where to go when edit is clicked");
                  //     },
                  //     icon: const Icon(
                  //       Icons.edit,
                  //       color: AppColor.white,
                  //     ),
                  //   );
                  // }
                  return IconButton(
                    onPressed: () => _navigateToFilterProjectsScreen(context),
                    icon: const Icon(
                      Icons.filter_list_outlined,
                      color: AppColor.white,
                    ),
                  );
                },
              ),
            )
          ],
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
        bottomNavigationBar: BlocBuilder<
            AuthorizedUserCubit,
            AuthorizedUserState>(
          builder: (context, state) {
            return Theme(
                data:
                Theme.of(context).copyWith(canvasColor: AppColor.black),
                child: BottomNavigation(
                  userType: state.currentUserType,
                ));
          },
        ),
      ),
    );
  }

  /// to navigate to filter projects screen
  void _navigateToFilterProjectsScreen(BuildContext context) =>
      RouteHelper().filterProjectsScreen(context);
}
