import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/screen_utils/screen_util.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
        left: Sizes.dimen_4.w,
        right: Sizes.dimen_4.w,
      ),
      color: AppColor.fadeVulcan,
      child: (Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // Menu icon button
          IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu,color: AppColor.white,),
          ),

          // Logo
          const Text("HOME",style:TextStyle(
            color: AppColor.white,
            fontSize: Sizes.dimen_18,
            fontWeight: FontWeight.bold,
          ),),


          // Search icon button
          IconButton(
            onPressed: () {
             /* showSearch(context: context, delegate: CustomSearchDelegate(
                searchMovieBloc: BlocProvider.of<SearchMovieBloc>(context),
              ));*/
            },
            icon: Icon(
              Icons.search,
              color: AppColor.white,
              size: Sizes.dimen_12.h,
            ),
          ),
        ],
      )),
    );
  }
}