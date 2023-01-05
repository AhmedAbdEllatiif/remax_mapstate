import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/constants/translate_constatns.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/btn_with_box_shadow.dart';

class BrokerRegisterForm extends StatefulWidget {
  final Function() onRegistrationSuccess;

  const BrokerRegisterForm({Key? key, required this.onRegistrationSuccess}) : super(key: key);

  @override
  State<BrokerRegisterForm> createState() => _BrokerRegisterFormState();
}

class _BrokerRegisterFormState extends State<BrokerRegisterForm> {
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


            /// numOfExperienceYears
            AppTextFormField(
              label: TranslateConstants.experienceYears.t(context),
              textInputType: TextInputType.number,
            ),


            AppTextFormField(
              //key: passwordKey,
              label: TranslateConstants.password.t(context),
              textInputType: TextInputType.visiblePassword,
            ),

            /// Choose favorite areas
            /// TODO: fetch areas
            /* ChooseFavoriteAreaWidget(
                        chooseFavoriteAreaCubit: _chooseFavoriteAreaCubit,
                        allAreas: const [
                          AreaEntity(id: 1, name: "Zayed"),
                          AreaEntity(id: 2, name: "October"),
                          AreaEntity(id: 3, name: "Sokhna"),
                          AreaEntity(id: 4, name: "Sahel"),
                          AreaEntity(id: 5, name: "New Capital"),
                        ],

                      ),*/

            /// Button Register a new client
            ButtonWithBoxShadow(
              text: TranslateConstants.register.t(context),
              onPressed: () {
                //widget.onRegistrationSuccess();
                _validate();
              },
            )
          ],
        ),
      ),
    );
  }


  void _validate(){
    if(_formKey.currentState != null){
      _formKey.currentState!.validate();
    }
  }
}
