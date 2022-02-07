import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';

class AreaCardWidget extends StatelessWidget {

  final AreaEntity area;

  const AreaCardWidget({Key? key, required this.area}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
      child:   CircleAvatar(
        backgroundColor: Colors.white,
        child: Center(
          child: Text(area.title,
          style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
