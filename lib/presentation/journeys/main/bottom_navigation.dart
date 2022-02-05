import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
      backgroundColor: Colors.blue,
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.support_outlined),
        label: 'Support',
        backgroundColor: Colors.red),
    BottomNavigationBarItem(
        icon: Icon(Icons.calculate_outlined),
        label: 'Calculator',
        backgroundColor: Colors.blue),
    /*BottomNavigationBarItem(
        icon: Icon(Icons.public),
        label: 'Network',
        backgroundColor: Colors.blue),*/
    BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),
        label: 'Profile',
        backgroundColor: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      //To stop animation
      backgroundColor: Colors.grey,
      selectedItemColor: Colors.white,
      showUnselectedLabels: false,
      currentIndex: 0,
      //onTap: (index) => setState(() => currentIndex = index),
      onTap: (index) {},
      items: bottomItems,
    );
  }
}
