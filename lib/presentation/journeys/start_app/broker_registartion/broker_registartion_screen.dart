import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/constants/translate_constatns.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/area_entity.dart';
import '../../../../domain/entities/params/app_text_form_field_params.dart';
import '../../../cubit/choose_favorite_area/choose_favorite_area_cubit.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/btn_with_box_shadow.dart';
import '../../../widgets/choose_area_widget.dart';

class BrokerRegistrationScreen extends StatefulWidget {
  const BrokerRegistrationScreen({Key? key}) : super(key: key);

  @override
  _BrokerRegistrationScreenState createState() => _BrokerRegistrationScreenState();
}

class _BrokerRegistrationScreenState extends State<BrokerRegistrationScreen> {

  final firstNameKey = GlobalKey();
  final lastNameKey = GlobalKey();
  final emailKey = GlobalKey();
  final numOfExperienceYears = GlobalKey();

  late final ChooseFavoriteAreaCubit _chooseFavoriteAreaCubit;

  @override
  void initState() {
    super.initState();
    _chooseFavoriteAreaCubit = getItInstance<ChooseFavoriteAreaCubit>();
  }

  @override
  void dispose() {
    _chooseFavoriteAreaCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslateConstants.brokerRegistration.t(context)),
      ),
      body: Scrollbar(
        child: Padding(
          padding: EdgeInsets.only(
            top: Sizes.dimen_10.h,
            left: Sizes.dimen_32.w,
            right: Sizes.dimen_32.w,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
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

                /// numOfExperienceYears
                AppTextFormField(
                  key: numOfExperienceYears,
                  params: TextFormFieldParams.fromTextInput(
                    appTextInput: AppTextInput.numOfExperienceYears,
                    context: context,
                  ),
                ),
                SizedBox(height: Sizes.dimen_5.h),


                /// Choose favorite areas
                ChooseFavoriteAreaWidget(
                  chooseFavoriteAreaCubit: _chooseFavoriteAreaCubit,
                  allAreas: const [
                    AreaEntity(id: 1, title: "Zayed"),
                    AreaEntity(id: 2, title: "October"),
                    AreaEntity(id: 3, title: "Sokhna"),
                    AreaEntity(id: 4, title: "Sahel"),
                    AreaEntity(id: 5, title: "New Capital"),
                  ],

                ),

                /// Button Register a new client
                ButtonWithBoxShadow(
                  text: TranslateConstants.register.t(context),
                  onPressed: () {
                    throw UnimplementedError("No Broker Registration Yet ...");
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
