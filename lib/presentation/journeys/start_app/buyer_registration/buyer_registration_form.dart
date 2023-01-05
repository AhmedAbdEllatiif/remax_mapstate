import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/widgets/app_text_form_field.dart';

import '../../../../common/constants/translate_constatns.dart';
import '../../../logic/cubit/choose_favorite_area/choose_favorite_area_cubit.dart';
import '../../../widgets/btn_with_box_shadow.dart';

class RegistrationFrom extends StatefulWidget {
  final Function() onSuccessRegister;
  final ChooseFavoriteAreaCubit chooseFavoriteAreaCubit;

  const RegistrationFrom(
      {Key? key,
      required this.chooseFavoriteAreaCubit,
      required this.onSuccessRegister})
      : super(key: key);

  @override
  State<RegistrationFrom> createState() => _RegistrationFromState();
}

class _RegistrationFromState extends State<RegistrationFrom> {
  /// form keu
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Wrap(
          alignment: WrapAlignment.center,
          //spacing: 20, // to apply margin in the main axis of the wrap
          runSpacing: Sizes.dimen_4.h,
          children: [
            /// firstName
            AppTextFormField(
              label: TranslateConstants.firstName.t(context),
              textInputType: TextInputType.name,
            ),

            /// lastName
            AppTextFormField(
              label: TranslateConstants.lastName.t(context),
              textInputType: TextInputType.name,
            ),

            /// email
            AppTextFormField(
              label: TranslateConstants.email.t(context),
              textInputType: TextInputType.emailAddress,
            ),

            /// password
            AppTextFormField(
              label: TranslateConstants.password.t(context),
              textInputType: TextInputType.visiblePassword,
            ),

            /// button
            ButtonWithBoxShadow(
              text: TranslateConstants.register.t(context).toUpperCase(),
              onPressed: widget.onSuccessRegister,
            )

            ///TODO fetch areas
            /*ChooseFavoriteAreaWidget(
              allAreas: const [
                AreaEntity(id: 1, name: "Zayed"),
                AreaEntity(id: 2, name: "October"),
                AreaEntity(id: 3, name: "Sokhna"),
                AreaEntity(id: 4, name: "Sahel"),
                AreaEntity(id: 5, name: "New Capital"),
              ],
              chooseFavoriteAreaCubit: chooseFavoriteAreaCubit,
            ),*/
          ],
        ),
      ),
    );
  }
}
