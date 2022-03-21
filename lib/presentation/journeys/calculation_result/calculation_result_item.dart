import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

class CalculationResultItem extends StatelessWidget {

  final String label;
  final String result;

  const CalculationResultItem ({Key? key, required this.label, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Sizes.dimen_4.h),
        child: Column(
          children: [
            /// label
            Text(label,style: Theme.of(context).textTheme.headline6!.copyWith(
              color: AppColor.geeBung
            ),),

            /// result
            RichText(
                text: TextSpan(
                  text: result,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: AppColor.geeBung,
                      fontWeight: FontWeight.bold
                  ),
                  children: [
                    TextSpan(
                      text: " LE",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: AppColor.geeBung,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ],
                )),



          ],
        ),
      ),
    );
  }
}
