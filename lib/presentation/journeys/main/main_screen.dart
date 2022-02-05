import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/cubit/navigation/navigation_cubit.dart';
import 'package:remax_mapstate/presentation/journeys/calculator/calculator_screen.dart';
import 'package:remax_mapstate/presentation/journeys/favorite/favorite_screen.dart';
import 'package:remax_mapstate/presentation/journeys/profile/profile_screen.dart';
import 'package:remax_mapstate/presentation/journeys/support/support_screen.dart';
import '../../cubit/current_user/current_user_cubit.dart';
import 'package:remax_mapstate/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:remax_mapstate/presentation/journeys/home/home_screen.dart';
import 'package:remax_mapstate/presentation/journeys/main/bottom_navigation.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getItInstance<NavigationCubit>(),
      child: Scaffold(
        drawer: const NavigationDrawer(),

        appBar: AppBar(
          centerTitle: true,
          title: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) {
              return Text(state.title.t(context));
            },
          ),
        ),

        body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            if (state is HomeState) {
              return const HomeScreen();
            }
            else if (state is FavoriteState) {
              return const FavoriteScreen();
            }
            else if (state is SupportState) {
              return const SupportScreen();
            }
            else if (state is ProfileState) {
              return const ProfileScreen();
            }
            else if (state is CalculatorState) {
              return const CalculatorScreen();
            }

            else {
              return const HomeScreen();
            }
          },
        ),

        // bottomNavigationBar
        bottomNavigationBar: BlocBuilder<CurrentUserCubit, CurrentUserState>(
          builder: (context, state) {
            return BottomNavigation(userType: state.userType,);
          },
        ),
      ),
    );
  }
}
