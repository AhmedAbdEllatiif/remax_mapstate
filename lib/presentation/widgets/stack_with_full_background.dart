import 'package:flutter/material.dart';

import 'city_background_widget.dart';

class StackScaffoldWithFullBackground extends StatelessWidget {
  final Widget? appBarTitle;
  final Widget body;
  final PreferredSizeWidget? bottomAppBar;

  const StackScaffoldWithFullBackground(
      {Key? key, this.appBarTitle, required this.body, this.bottomAppBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        /// background img
        const CityBackgroundWidget(),

        /// scaffold
        Scaffold(
          //==> scaffold bg
          backgroundColor: Colors.transparent,

          //==> appbar
          appBar: appBarTitle == null
              ? null
              : AppBar(
                  title: appBarTitle,
                  backgroundColor: Colors.transparent,

                ),



          //==> body
          body: body,
        ),
      ],
    );
  }
}
