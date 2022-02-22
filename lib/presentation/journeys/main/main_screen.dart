import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/data/tables/current_user_table.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/current_user.dart';
import 'package:remax_mapstate/presentation/cubit/navigation/navigation_cubit.dart';
import 'package:remax_mapstate/presentation/journeys/calculator/calculator_screen.dart';
import 'package:remax_mapstate/presentation/journeys/favorite/favorite_screen.dart';
import 'package:remax_mapstate/presentation/journeys/profile/profile_screen.dart';
import 'package:remax_mapstate/presentation/journeys/support/support_screen.dart';
import '../../../common/enums/user_types.dart';
import '../../cubit/current_user/current_user_cubit.dart';
import 'package:remax_mapstate/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:remax_mapstate/presentation/journeys/home/home_screen.dart';
import 'package:remax_mapstate/presentation/journeys/main/bottom_navigation.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late  NavigationCubit navigationCubit;


  @override
  void initState() {
    super.initState();
    print("MainScreen >> initState is Here");
    navigationCubit = getItInstance<NavigationCubit>();
  }

  @override
  void dispose() {
    print("MainScreen >> Dispose is Here");
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
          title: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) {
              return Text(state.title.t(context));
            },
          ),
        ),

        body: BlocBuilder<NavigationCubit, NavigationState>(
          bloc: navigationCubit,
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
        bottomNavigationBar: BlocBuilder<CurrentUserCubit, CurrentUserTable>(
          builder: (context, currentUser) {
            print("CurrentUser ${CurrentUserEntity(currentUserStr: currentUser.currentUser).userType} \n str >> ${CurrentUserEntity(currentUserStr: currentUser.currentUser).userType.toShortString()}");
            return BottomNavigation(userType: CurrentUserEntity(currentUserStr: currentUser.currentUser).userType,);
          },
        ),
      ),
    );
  }
}
