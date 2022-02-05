import 'package:flutter/material.dart';
import 'package:remax_mapstate/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:remax_mapstate/presentation/journeys/home/home_screen.dart';
import 'package:remax_mapstate/presentation/journeys/main/bottom_navigation.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  const NavigationDrawer(),

      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),

      body: const HomeScreen(),

       // bottomNavigationBar
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
