import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/extensions/widgetExtension.dart';

import '../../common/constants/sizes.dart';
import '../../common/enums/animation_type.dart';
import '../themes/theme_color.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? errorText;
  final String? label;
  final Icon? icon;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? minLength;
  final bool? enabled;
  final String? rePassword;
  final double? height;
  final double? width;
  final int? minLines;
  final int? maxLines;
  final EdgeInsets? margin;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final bool withFocusedBorder;
  final bool validateOnSubmit;

  const AppTextFormField({
    Key? key,
    this.controller,
    this.errorText,
    this.icon,
    this.validator,
    this.textInputType = TextInputType.text,
    this.label,
    this.textInputAction = TextInputAction.next,
    this.maxLength,
    this.minLength,
    this.enabled,
    this.rePassword,
    this.height,
    this.width,
    this.margin,
    this.labelStyle,
    this.textStyle,
    this.withFocusedBorder = true,
    this.validateOnSubmit = true,
    this.minLines = 1,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late bool _isObscure;
  late Widget? _icon;

  @override
  void initState() {
    _isObscure = _isPasswordTextInputType();
    _icon = _buildIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      margin: widget.margin,
      child: Card(
        color: AppColor.extraTransparentGeeBung,
        elevation: 0.0,
        //shadowColor: AppColor.absoluteFadeGeeBung,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
        ),
        child: TextFormField(
          // controller
          controller: widget.controller,

          // enabled
          enabled: widget.enabled,

          // max length with counter
          //maxLength: widget.maxLength,

          // max length without counter
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.maxLength),
          ],

          // max and min lines
          minLines: widget.textInputType == TextInputType.visiblePassword
              ? 1
              : widget.minLines,
          maxLines: widget.textInputType == TextInputType.visiblePassword
              ? 1
              : widget.maxLength,

          //initialValue: initialValue,

          // text style
          style: widget.textStyle ?? const TextStyle(color: AppColor.geeBung),

          textInputAction: widget.textInputAction,

          initialValue: '',
          cursorColor: AppColor.geeBung,

          decoration: InputDecoration(
            //filled: true,

            // to decrease the height size
            //isDense: true,
            contentPadding: widget.icon == null ||
                    widget.textInputType == TextInputType.visiblePassword
                ? const EdgeInsets.fromLTRB(10, 10, 10, 0)
                : const EdgeInsets.fromLTRB(8, 8, 8, 0),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
              borderSide: const BorderSide(color: AppColor.geeBung, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
              borderSide: const BorderSide(
                  color: AppColor.absoluteTransparentGeeBung, width: 0.7),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
            ),
            fillColor: AppColor.geeBung,

            // errorMaxLines: ,

            // label text
            labelText: widget.label,
            labelStyle: widget.labelStyle ??
                Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: AppColor.geeBung,
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.dimen_16,
                    ),

            //hintText:  widget.label,
            //hintStyle:  const TextStyle(color: AppColor.white),

            // error text
            errorText: widget.errorText != null
                ? widget.errorText!.isNotEmpty
                    ? widget.errorText
                    : null
                : null,
            errorStyle: Theme.of(context).textTheme.caption!.copyWith(
              color: AppColor.geeBung,
              fontWeight: FontWeight.bold
            ),

            // icon
            suffixIcon: _icon,
          ),

          // keyboardType
          keyboardType: widget.textInputType,

          obscureText: _isObscure,

          // validator
          validator:
              widget.validateOnSubmit ? widget.validator ?? validate : null,
        ),
      ),
    ).animate(
        slideDuration: const Duration(milliseconds: 300),
        fadeDuration: const Duration(milliseconds: 300),
        map: {
          AnimationType.slide: {
            SlideOffset.begin: const Offset(0.0, 0.5),
            SlideOffset.end: const Offset(0.0, 0.0),
          },
          AnimationType.fade: {
            FadeOpacity.begin: 0.5,
            FadeOpacity.end: 1.0,
          },
        });
  }

  /// return true if the textInput is visiblePassword
  bool _isPasswordTextInputType() =>
      widget.textInputType == TextInputType.visiblePassword;

  /// To build the icon
  Widget? _buildIcon() {
    // widget icon not null
    if (widget.icon != null) {
      return widget.icon;
    }

    // default password icon
    if (_isPasswordTextInputType()) {
      return IconButton(
        icon: Icon(
          _isObscure
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: AppColor.geeBung,
        ),
        onPressed: () {
          setState(() {
            _isObscure = !_isObscure;
          });
        },
      ).animate(map: {
        AnimationType.rotate: {TriggerOn: TriggerOn.click}
      });
    }

    return null;
  }

  /// To validate
  String? validate(String? value) {
    if (value != null) {
      if (widget.textInputType == TextInputType.emailAddress) {
        return emailValidation(value);
      }
      if (_isPasswordTextInputType()) {
        return passwordValidation(value);
      }
      if (widget.minLength != null) {
        if (widget.minLength! > value.length) {
          return "الحد الأدنى من الأحرف هو ${widget.minLength}";
        }
      }
    }

    if (value == null) return "* مطلوب ادخاله";
    if (value.isEmpty) return "* مطلوب ادخاله";
    return null;
  }

  /// return a nullable string of email validation
  String? emailValidation(String value) {
    if (value.isEmpty) return "* الرجاء إدخال البريد الخاص بك";

    if (!value.matchEmail) return "* عنوان البريد الإلكتروني غير صالح";

    return null;
  }

  /// return a nullable string of password validation
  String? passwordValidation(String value) {
    /*if (widget.rePassword != null) {
      if (value != widget.rePassword) {
        return "* يجب أن تكون كلمات المرور هي نفسها";
      }
    }*/

    // empty value
    if (value.isEmpty) return '* من فضلك أدخل كلمة مرور';

    // not contains a uppercase
    if (!value.containsUppercase) {
      return '* يجب تضمين حرف علوي واحد على الأقل';
    }

    // not contains a lowercase
    if (!value.containsLowercase) {
      return '* يجب تضمين حرف سفلي واحد على الأقل';
    }

    // not contains a special character
    if (!value.containsSpecialCharacter) {
      return '* يجب تضمين حرف خاص واحد على الأقل';
    }

    // not contains a number
    if (!value.containsNumber) return '* يجب تضمين رقم واحد على الأقل';

    // less than 8 characters
    if (value.length < 8) return '* يجب أن تكون كلمة المرور 8 أحرف على الأقل';

    return null;
  }
}
