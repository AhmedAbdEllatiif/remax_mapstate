import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/cubit/residential_projects/residential_projects_cubit.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

class UnitTypeCardWidget extends StatelessWidget {
  const UnitTypeCardWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ResidentialCubit>(context).loadProjects(0);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_12.w))
        ),
        child: Center(
          child: Text("Item",
            maxLines: 2,
            style: Theme.of(context).textTheme.royalBlueBodyText2,
          ),
        ),
      ),
    );
  }
}
