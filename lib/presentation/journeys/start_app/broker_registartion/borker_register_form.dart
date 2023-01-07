import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/enums/user_register_group.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/constants/translate_constatns.dart';
import '../../../logic/cubit/update_default_user/update_default_user_cubit.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/btn_with_box_shadow.dart';

class BrokerRegisterForm extends StatefulWidget {
  final Function(UserEntity) onRegistrationSuccess;

  const BrokerRegisterForm({Key? key, required this.onRegistrationSuccess})
      : super(key: key);

  @override
  State<BrokerRegisterForm> createState() => _BrokerRegisterFormState();
}

class _BrokerRegisterFormState extends State<BrokerRegisterForm> {
  /// form key
  final _formKey = GlobalKey<FormState>();

  ///UpdateDefaultUserCubit
  late final UpdateDefaultUserCubit _updateDefaultUserCubit;

  /// controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateDefaultUserCubit = getItInstance<UpdateDefaultUserCubit>();
  }

  @override
  void dispose() {
    _updateDefaultUserCubit.close();
    firstNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _updateDefaultUserCubit,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocConsumer<UpdateDefaultUserCubit, UpdateDefaultUserState>(
          listener: (context, state) {
            if (state is SuccessUpdateDefaultUser) {
              log("UserEntity: ${state.userEntity}");
              widget.onRegistrationSuccess(state.userEntity);
            }

            //==> ErrorWhileUpdatingDefaultUser
            if (state is ErrorWhileUpdatingDefaultUser) {}
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Wrap(
                alignment: WrapAlignment.center,
                //spacing: 20, // to apply margin in the main axis of the wrap
                runSpacing: Sizes.dimen_4.h,
                children: [
                  /// firstName
                  AppTextFormField(
                    controller: firstNameController,
                    label: TranslateConstants.fullName.t(context),
                    textInputType: TextInputType.name,
                  ),

                  /// phone number
                  AppTextFormField(
                    controller: phoneNumberController,
                    label: TranslateConstants.phoneNumber.t(context),
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value == null) {
                        return TranslateConstants.passwordRequired.t(context);
                      }

                      return value.matchPhoneNumber
                          ? null
                          : TranslateConstants.invalidPhoneNumber.t(context);
                    },
                  ),

                  /// email
                  AppTextFormField(
                    controller: emailController,
                    errorText: state is UpdateDefaultUserEmailAlreadyExists
                        ? TranslateConstants.emailAlreadyExists.t(context)
                        : null,
                    label: TranslateConstants.email.t(context),
                    textInputType: TextInputType.emailAddress,
                  ),

                  /// numOfExperienceYears
                  /*AppTextFormField(
                    label: TranslateConstants.experienceYears.t(context),
                    textInputType: TextInputType.number,
                  ),*/

                  /// password
                  AppTextFormField(
                    controller: passwordController,
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
                  state is LoadingToUpdateDefaultUser
                      ? const LoadingWidget()
                      : ButtonWithBoxShadow(
                          text: TranslateConstants.register.t(context),
                          onPressed: () {
                            if (_validate()) {
                              _updateUser();
                            }
                          },
                        )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// validate
  bool _validate() {
    //==> validate on form and received images list
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }
    return false;
  }

  /// Update user
  void _updateUser() {
    final firstName = firstNameController.value.text;
    final phoneNum = phoneNumberController.value.text;
    final email = emailController.value.text;
    final password = passwordController.value.text;

    _updateDefaultUserCubit.updateDefaultUser(
      email: email,
      firstName: firstName,
      phoneNumber: phoneNum,
      password: password,
      userRegisterGroup: UserRegisterGroup.broker,
    );
  }
}
