import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/functions/get_user_token.dart';
import 'package:remax_mapstate/common/functions/hide_keyboard.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/users/ambassador_entity.dart';
import 'package:remax_mapstate/presentation/widgets/app_error_widget.dart';
import 'package:remax_mapstate/presentation/widgets/app_text_form_field.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';
import 'package:remax_mapstate/presentation/widgets/stack_with_full_background.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/constants/translate_constatns.dart';
import '../../../common/functions/navigate_to_login.dart';
import '../../arguments/update_ambassador_args.dart';
import '../../logic/cubit/update_ambassador_date/update_ambassador_data_cubit.dart';
import '../../widgets/btn_with_box_shadow.dart';

class UpdateAmbassadorDataScreen extends StatefulWidget {
  final UpdateAmbassadorArguments arguments;

  const UpdateAmbassadorDataScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<UpdateAmbassadorDataScreen> createState() =>
      _UpdateAmbassadorDataScreenState();
}

class _UpdateAmbassadorDataScreenState
    extends State<UpdateAmbassadorDataScreen> {
  /// _ambassadorEntity
  late final AmbassadorEntity _ambassadorEntity;

  /// CompleteAmbassadorDataCubit
  late final UpdateAmbassadorDataCubit _updateAmbassadorDataCubit;

  /// Controllers
  late final TextEditingController currentJobController;

  /// formKey
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _ambassadorEntity = widget.arguments.ambassadorEntity;
    _updateAmbassadorDataCubit = widget.arguments.completeAmbassadorDataCubit;
    currentJobController = TextEditingController();
  }

  @override
  void dispose() {
    currentJobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _updateAmbassadorDataCubit,
      child: StackScaffoldWithFullBackground(
        /// appBarTitle
        appBarTitle: Text(TranslateConstants.updateProfile.t(context)),
        body:
            BlocConsumer<UpdateAmbassadorDataCubit, UpdateAmbassadorDataState>(
          listener: (context, state) {
            if (state is AmbassadorDataUpdatedSuccessfully) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            /*
          *
          *
          * unAuthenticated
          *
          *
          * */
            if (state is UnAuthorizedUpdateAmbassadorData) {
              return Center(
                  child: AppErrorWidget(
                appTypeError: AppErrorType.unAuthorized,
                onPressedRetry: () => navigateToLogin(context),
              ));
            }

            /*
          *
          *
          * error
          *
          *
          * */
            if (state is ErrorWhileUpdatingAmbassadorData) {
              return Center(
                  child: AppErrorWidget(
                appTypeError: state.appError.appErrorType,
                onPressedRetry: () => _updateProfile(),
              ));
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                top: Sizes.dimen_10.h,
                left: Sizes.dimen_32.w,
                right: Sizes.dimen_32.w,
              ),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppTextFormField(
                          label: TranslateConstants.currentJob.t(context),
                          controller: currentJobController,
                        ),

                        //==> button update
                        state is LoadingUpdateAmbassadorData
                            ? const Center(
                                child: LoadingWidget(),
                              )
                            : ButtonWithBoxShadow(
                                text:
                                    TranslateConstants.updateProfile.t(context),
                                onPressed: () {
                                  if (_validate()) {
                                    _updateProfile();
                                  }
                                },
                              ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _updateProfile() {
    final userToken = getUserToken(context);
    final ambassadorId = _ambassadorEntity.id;
    final currentJobTitle = currentJobController.value.text;

    _updateAmbassadorDataCubit.tryToUpdateAmbassadorData(
      userId: ambassadorId,
      userToken: userToken,
      currentJobTitle: currentJobTitle,
    );
  }

  /// validate
  bool _validate() {
    hideKeyboard();

    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }

    return false;
  }
}
