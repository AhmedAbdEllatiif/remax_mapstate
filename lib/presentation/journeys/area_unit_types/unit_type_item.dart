import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/widgets/container_with_gradient.dart';
import '../../themes/theme_color.dart';

class UnitTypeItem extends StatelessWidget {
  final String unitTypeName;
  final Function(String) onPressed;

  const UnitTypeItem({Key? key, required this.unitTypeName, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // BlocProvider.of<UnitTypeNamesCubit>(context).loadProjects(0);
        onPressed(unitTypeName);
      },
      child: Card(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColor.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
          ),          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),


              child: _buildText(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context){
    if(unitTypeName.contains(" ")){
      return Text(
        unitTypeName.toUpperCase(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: AppColor.white, fontWeight: FontWeight.bold),
      );
    }else{
     return FittedBox(
        fit: BoxFit.fill,
        child: Text(
          unitTypeName.toUpperCase(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppColor.white, fontWeight: FontWeight.bold),
        ),
      );
    }
  }
}
