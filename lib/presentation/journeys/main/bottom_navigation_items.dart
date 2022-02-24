import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

class BottomNavigationItems{

  BottomNavigationItems();


  List<BottomNavigationBarItem> clientItems(BuildContext context){
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home_outlined),
        label: TranslateConstants.home.t(context),
      ),


        const BottomNavigationBarItem(
            icon: Icon(Icons.calculate_outlined),
            label: 'Calculator',
           ),


        BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_border_outlined),
            label: TranslateConstants.favorite.t(context),
        ),



      BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          label: TranslateConstants.profile.t(context),
          ),
    ];
  }


  List<BottomNavigationBarItem> broker(BuildContext context){
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home_outlined),
        label: TranslateConstants.home.t(context),

      ),



        BottomNavigationBarItem(
            icon: const Icon(Icons.support_outlined),
            label: TranslateConstants.support.t(context),
           ),


        const BottomNavigationBarItem(
            icon: Icon(Icons.calculate_outlined),
            label: 'Calculator',
           ),


      BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          label: TranslateConstants.profile.t(context),
         ),
    ];
  }

}