import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/data/data_sources/remote_data_source.dart';
import 'package:remax_mapstate/data/models/mutation/login/login_request_model.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/authorized_user_entity.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/app_text_form_field.dart';

import '../../../common/constants/translate_constatns.dart';
import '../../logic/cubit/login/login_cubit.dart';
import '../../widgets/btn_with_box_shadow.dart';
import '../../widgets/loading_widget.dart';

class LoginForm extends StatefulWidget {
  final Function(
    String token,
    AuthorizedUserEntity authorizedUserEntity,
  ) onSuccessLogin;

  final String email;
  final String password;

  const LoginForm({
    Key? key,
    required this.onSuccessLogin,
    this.email = "",
    this.password = "",
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  /// Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// formKey
  final _formKey = GlobalKey<FormState>();

  /// LoginCubit
  late final LoginCubit _loginCubit;

  @override
  void initState() {
    super.initState();
    _loginCubit = getItInstance<LoginCubit>();
    if (widget.email.isNotEmpty) {
      emailController.text = widget.email;
      passwordController.text = widget.password;
    }

    if (widget.email.isNotEmpty && widget.password.isNotEmpty) {
      _loginCubit.tryToLogin(
        email: widget.email,
        password: widget.password,
      );
    }
  }

  @override
  void dispose() {
    _loginCubit.close();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginCubit,
      child: Container(
        child: Builder(builder: (context) {
          return BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              //==> success
              if (state is LoginSuccess) {
                final token = state.loginEntity.userToken;
                final authorizedUserEntity =
                    state.loginEntity.authorizedUserEntity;
                widget.onSuccessLogin(token, authorizedUserEntity);
              }

              //==> wrong email or password
              if (state is WrongEmailOrPassword) {
                log(".............Wrong Email or Password..................");
              }

              //==> error
              if (state is ErrorWhileLogin) {
                log(".............Error ${state.appError}.................");
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    //spacing: 20, // to apply margin in the main axis of the wrap
                    runSpacing: Sizes.dimen_4.h,
                    children: [
                      /// email
                      AppTextFormField(
                        controller: emailController,
                        enabled: state is! LoadingLogin,
                        label: TranslateConstants.email.t(context),
                        textInputType: TextInputType.emailAddress,
                      ),

                      /// password
                      AppTextFormField(
                        controller: passwordController,
                        enabled: state is! LoadingLogin,
                        label: TranslateConstants.password.t(context),
                        textInputType: TextInputType.visiblePassword,
                      ),

                      if (state is WrongEmailOrPassword)
                        Text(
                          TranslateConstants.wrongEmailOrPassword.t(context),
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: AppColor.red,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),

                      /// ButtonWithBoxShadow
                      state is LoadingLogin
                          ? const LoadingWidget()
                          : ButtonWithBoxShadow(
                              text: TranslateConstants.login
                                  .t(context)
                                  .toUpperCase(),
                              onPressed: () {
                                if (_validate()) {
                                  _loginUser();
                                }
                              },
                            )
                    ],
                  ),
                ),
              );
            },
          );
        }),
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

  /// loginUser
  void _loginUser() {
    final String email = emailController.value.text;
    final String password = passwordController.value.text;

    _loginCubit.tryToLogin(
      email: email,
      password: password,
    );
  }
}
