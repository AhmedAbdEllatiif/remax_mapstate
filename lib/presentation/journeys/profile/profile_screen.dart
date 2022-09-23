import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/profile/user_data_item.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/city_background_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        CityBackgroundWidget(),

        Padding(
          padding:  EdgeInsets.only(top: Sizes.dimen_18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const CircleAvatar(
                backgroundColor: AppColor.transparentGeeBung,
                radius: 100,
                backgroundImage: AssetImage(AssetsConstants.person2),
              ), //CircleAvatar



              Padding(
                padding:  EdgeInsets.only(top: Sizes.dimen_22.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _userData(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _userData(){
    return [
      UserDataItem(keyData: "Name",value: "John Michael",),
      UserDataItem(keyData: "Email",value: "john@example.com",),
      UserDataItem(keyData: "phone",value: "+2010058866800",),
    ];
  }
}
