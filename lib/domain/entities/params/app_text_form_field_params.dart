import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

enum AppTextInput { lastName, firstName, email, job, numOfExperienceYears }

class TextFormFieldParams {
  final TextInputType keyboardType;
  final TextInputAction nextInputAction;
  final String label;

  const TextFormFieldParams({
    required this.keyboardType,
    required this.nextInputAction,
    required this.label,
  });

  /// factory according to AppTextInput
  factory TextFormFieldParams.fromTextInput({
    required AppTextInput appTextInput,
    required BuildContext context,
  }) {
    switch (appTextInput) {

      /// firstName
      case AppTextInput.firstName:
        return  TextFormFieldParams(
          label: TranslateConstants.firstName.t(context),
          keyboardType: TextInputType.name,
          nextInputAction: TextInputAction.next,
        );

      /// lastName
      case AppTextInput.lastName:
        return  TextFormFieldParams(
          label: TranslateConstants.lastName.t(context),
          keyboardType: TextInputType.name,
          nextInputAction: TextInputAction.next,
        );

      /// email
      case AppTextInput.email:
        return  TextFormFieldParams(
          label: TranslateConstants.email.t(context),
          keyboardType: TextInputType.emailAddress,
          nextInputAction: TextInputAction.next,
        );

      /// job
      case AppTextInput.job:
        return  TextFormFieldParams(
          label: TranslateConstants.currentJob.t(context),
          keyboardType: TextInputType.text,
          nextInputAction: TextInputAction.next,
        );

      /// numOfExperienceYears
      case AppTextInput.numOfExperienceYears:
        return  TextFormFieldParams(
          label: TranslateConstants.experienceYears.t(context),
          keyboardType: TextInputType.number,
          nextInputAction: TextInputAction.next,
        );
    }
  }
}
