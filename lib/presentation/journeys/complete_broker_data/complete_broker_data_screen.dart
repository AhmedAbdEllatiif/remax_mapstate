import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/data/models/success_model.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/arguments/complete_broker_data_arguments.dart';
import 'package:remax_mapstate/domain/entities/users/user_entity.dart';
import 'package:remax_mapstate/presentation/logic/cubit/complete_broker_data/complete_broker_data_cubit.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../../common/constants/sizes.dart';
import '../../../domain/entities/area_entity.dart';
import '../../logic/cubit/choose_favorite_area/choose_favorite_area_cubit.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/btn_with_box_shadow.dart';
import '../../widgets/choose_area_widget.dart';
import '../../widgets/stack_with_full_background.dart';

class CompleteBrokerDataScreen extends StatefulWidget {
  final CompleteBrokerDataArguments completeBrokerDataArguments;

  const CompleteBrokerDataScreen({
    Key? key,
    required this.completeBrokerDataArguments,
  }) : super(key: key);

  @override
  State<CompleteBrokerDataScreen> createState() =>
      _CompleteBrokerDataScreenState();
}

class _CompleteBrokerDataScreenState extends State<CompleteBrokerDataScreen> {
  /// Controllers
  final TextEditingController experienceYearsController =
      TextEditingController();

  /// CompleteBrokerDataCubit
  late final CompleteBrokerDataCubit _completeBrokerDataCubit;
  late final ChooseFavoriteAreaCubit _chooseFavoriteAreaCubit;

  /// UserEntity
  late final UserEntity _userEntity;

  /// formKey
  final _formKey = GlobalKey<FormState>();

  /// selected areas to send
  List<AreaEntity> _selectedAreas = const [];

  /// error text
  String errorText = "";

  @override
  void initState() {
    super.initState();

    // init _completeBrokerDataCubit
    _completeBrokerDataCubit =
        widget.completeBrokerDataArguments.completeBrokerDataCubit;

    // init _chooseFavoriteAreaCubit
    _chooseFavoriteAreaCubit = getItInstance<ChooseFavoriteAreaCubit>();

    // init userEntity
    _userEntity = widget.completeBrokerDataArguments.userEntity;
  }

  @override
  void dispose() {
    experienceYearsController.dispose();
    _chooseFavoriteAreaCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _chooseFavoriteAreaCubit),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CompleteBrokerDataCubit, CompleteBrokerDataState>(
              bloc: _completeBrokerDataCubit,
              listener: (context, state) {
                if (state is BrokerDataCompletedSuccessfully) {
                  Navigator.pop(context);
                }
              }),

          // ChooseFavoriteAreaCubit
          BlocListener<ChooseFavoriteAreaCubit, ChooseFavoriteAreaState>(
              listener: (context, state) {
            //_selectedAreas.clear();
            _selectedAreas = state.selectedAreas;
            _showOrHideErrorText();
          })
        ],
        child: StackScaffoldWithFullBackground(
          /// appBarTitle
          appBarTitle: Text(TranslateConstants.updateProfile.t(context)),

          /// body
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_10.h,
                left: Sizes.dimen_32.w,
                right: Sizes.dimen_32.w,
              ),
              child:
                  BlocBuilder<CompleteBrokerDataCubit, CompleteBrokerDataState>(
                bloc: _completeBrokerDataCubit,
                builder: (context, state) {
                  log("State >>> $state");
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //=> experienceYears
                      Form(
                        key: _formKey,
                        child: AppTextFormField(
                          controller: experienceYearsController,
                          errorText: state is ExperienceYearsMustBeANumber
                              ? "* Must be a number"
                              : null,
                          label: TranslateConstants.experienceYears.t(context),
                          textInputType: TextInputType.number,
                        ),
                      ),

                      //==> choose favorite areas
                      ChooseFavoriteAreaWidget(
                        chooseFavoriteAreaCubit: _chooseFavoriteAreaCubit,
                      ),

                      //==> error text
                      if (errorText.isNotEmpty)
                        Text(
                          errorText,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: AppColor.red,
                              ),
                        ),

                      //==> button update
                      state is LoadingCompleteBrokerDataInitial
                          ? const Center(
                              child: LoadingWidget(),
                            )
                          : ButtonWithBoxShadow(
                              text: TranslateConstants.updateProfile.t(context),
                              onPressed: () {
                                if (_validate()) {
                                  _updateProfile();
                                  log("Selected Areas: $_selectedAreas");
                                }

                              },
                            ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateProfile() {
    final yearsOfExperience = experienceYearsController.value.text;
    log("BrokerId: ${_userEntity.id}");
    _completeBrokerDataCubit.completeBrokerData(
      brokerId: _userEntity.id,
      yearsOfExperience: yearsOfExperience,
      favRegions: _selectedAreas,
    );
  }

  /// validate
  bool _validate() {
    _showOrHideErrorText();
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }

    if (_selectedAreas.isEmpty) return false;

    return false;
  }

  ///  to show or hide the error text of the selected regions
  void _showOrHideErrorText() {
    setState(() {
      /// TODO add translate
      errorText =
          _selectedAreas.isEmpty ? "* Select your favorites regions" : "";
    });
  }
}
