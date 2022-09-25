import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/widgets/container_with_gradient.dart';
import '../../themes/theme_color.dart';

class UnitTypeCardWidget extends StatelessWidget {
  final String unitTypeName;
  const UnitTypeCardWidget({Key? key, required this.unitTypeName}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       // BlocProvider.of<UnitTypeNamesCubit>(context).loadProjects(0);
      },
      child: Card(
        elevation: 10,
        color: AppColor.geeBung,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppUtils.cornerRadius.w))
        ),
        child: ContainerWithGradient(
          child: Center(
            child: Text(unitTypeName,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: AppColor.black,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}
