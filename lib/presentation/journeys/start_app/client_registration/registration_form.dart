import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/domain/entities/params/app_text_form_field_params.dart';
import 'package:remax_mapstate/presentation/cubit/choose_favorite_area/choose_favorite_area_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/app_text_form_field.dart';
import 'package:remax_mapstate/presentation/widgets/choose_area_widget.dart';

class RegistrationFrom extends StatelessWidget {

  final ChooseFavoriteAreaCubit chooseFavoriteAreaCubit;

   RegistrationFrom({Key? key, required this.chooseFavoriteAreaCubit}) : super(key: key);


  final firstNameKey = GlobalKey();
  final lastNameKey = GlobalKey();
  final emailKey = GlobalKey();
  final registrationPasswordKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// firstName
        AppTextFormField(
          key: firstNameKey,
          params: TextFormFieldParams.fromTextInput(
            appTextInput: AppTextInput.firstName,
            context: context,
          ),
        ),
        SizedBox(height: Sizes.dimen_5.h),

        /// lastName
        AppTextFormField(
          key: lastNameKey,
          params: TextFormFieldParams.fromTextInput(
            appTextInput: AppTextInput.lastName,
            context: context,
          ),
        ),
        SizedBox(height: Sizes.dimen_5.h),

        /// email
        AppTextFormField(
          key: emailKey,
          params: TextFormFieldParams.fromTextInput(
            appTextInput: AppTextInput.email,
            context: context,
          ),
        ),
        SizedBox(height: Sizes.dimen_5.h),

        /// email
        AppTextFormField(
          key: registrationPasswordKey,
          params: TextFormFieldParams.fromTextInput(
            appTextInput: AppTextInput.password,
            context: context,
          ),
        ),
        SizedBox(height: Sizes.dimen_5.h),

        ChooseFavoriteAreaWidget(
          allAreas: const [
            AreaEntity(id: 1, title: "Zayed"),
            AreaEntity(id: 2, title: "October"),
            AreaEntity(id: 3, title: "Sokhna"),
            AreaEntity(id: 4, title: "Sahel"),
            AreaEntity(id: 5, title: "New Capital"),
          ],
          chooseFavoriteAreaCubit: chooseFavoriteAreaCubit,
        ),

      ],
    );
  }
}
