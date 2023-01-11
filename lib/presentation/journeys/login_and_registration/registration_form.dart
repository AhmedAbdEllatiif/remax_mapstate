import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/register_entity.dart';

import 'package:remax_mapstate/presentation/logic/cubit/auth/register_new_user/register_new_user_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/constants/translate_constatns.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/btn_with_box_shadow.dart';

class BrokerRegisterForm extends StatefulWidget {
  final Function(RegisterEntity, UserType) onRegistrationSuccess;
  final UserType userType;

  const BrokerRegisterForm({
    Key? key,
    required this.onRegistrationSuccess,
    required this.userType,
  }) : super(key: key);

  @override
  State<BrokerRegisterForm> createState() => _BrokerRegisterFormState();
}

class _BrokerRegisterFormState extends State<BrokerRegisterForm> {
  /// form key
  final _formKey = GlobalKey<FormState>();

  ///UpdateDefaultUserCubit
  late final RegisterNewUserCubit _registerNewUserCubit;

  /// controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _registerNewUserCubit = getItInstance<RegisterNewUserCubit>();
  }

  @override
  void dispose() {
    _registerNewUserCubit.close();
    firstNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _registerNewUserCubit,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocConsumer<RegisterNewUserCubit, RegisterNewUserState>(
          listener: (context, state) {
            if (state is SuccessRegister) {
              log("registerEntity: ${state.registerEntity}");
              widget.onRegistrationSuccess(
                state.registerEntity,
                widget.userType,
              );
            }

            //==> ErrorWhileUpdatingDefaultUser
            if (state is ErrorWhileRegister) {}
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
                    enabled: state is! LoadingToRegister,
                    errorText: state is RegisterEmailAlreadyExists
                        ? TranslateConstants.emailAlreadyExists.t(context)
                        : null,
                    label: TranslateConstants.email.t(context),
                    textInputType: TextInputType.emailAddress,
                  ),

                  /// password
                  AppTextFormField(
                    controller: passwordController,
                    enabled: state is! LoadingToRegister,
                    label: TranslateConstants.password.t(context),
                    textInputType: TextInputType.visiblePassword,
                  ),

                  /// Button Register a new client
                  state is LoadingToRegister
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
    final email = emailController.value.text;
    final password = passwordController.value.text;

    _registerNewUserCubit.register(
      email: email,
      password: password,
    );
  }
}
