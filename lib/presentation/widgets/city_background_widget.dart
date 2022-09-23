import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';

class CityBackgroundWidget extends StatelessWidget {
  const CityBackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              AssetsConstants.cityModified,
              fit: BoxFit.cover,
            )),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.8),
        ),
      ],
    );
  }
}
