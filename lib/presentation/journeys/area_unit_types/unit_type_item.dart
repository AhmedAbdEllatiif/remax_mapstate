import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/widgets/container_with_gradient.dart';
import '../../themes/theme_color.dart';

class UnitTypeItem extends StatelessWidget {
  final String unitTypeName;

  const UnitTypeItem({Key? key, required this.unitTypeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // BlocProvider.of<UnitTypeNamesCubit>(context).loadProjects(0);
      },
      child: Card(
        color: AppColor.geeBung,
        child: ContainerWithGradient(
          child: Center(
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
            .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
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
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
      );
    }
  }
}
