import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/cubit/developer_contact/developer_contact_cubit.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

class LocationDataItem extends StatelessWidget {
  final String dataKey;
  final dynamic value;

  const LocationDataItem({Key? key, required this.dataKey, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        /// head section text
        RichText(
          text: TextSpan(
            text: dataKey,
            style: Theme.of(context).textTheme.geryCaption,
            children: [
              TextSpan(
                text: " ${TranslateConstants.headOffice.t(context)}",
                style: Theme.of(context).textTheme.geryCaption,
              )
            ],
          ),
        ),


        /// get directions
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_20.w)),
          child: InkWell(
            onTap: () {
              context.read<DeveloperContactCubit>().openMap();
            },
            splashColor: AppColor.vulcan,
            child: Padding(
              padding: const EdgeInsets.all(Sizes.dimen_6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: Theme.of(context)
                        .textTheme
                        .boldVulcanBodyText2
                        .copyWith(color: AppColor.royalBlue),
                  ),
                  SizedBox(
                    width: Sizes.dimen_4.w,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: AppColor.royalBlue,
                    size: Sizes.dimen_8.h,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
