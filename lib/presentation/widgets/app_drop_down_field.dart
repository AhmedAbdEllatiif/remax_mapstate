import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';


import '../../common/constants/app_utils.dart';
import '../themes/theme_color.dart';

class AppDropDownField extends StatefulWidget {
  final String? hintText;
  final String? errorText;
  final String? initialValue;
  final List<String> itemsList;
  final Function(String?) onChanged;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final bool isLastItemHighlighted;
  final bool isDense;

  const AppDropDownField({
    Key? key,
    required this.itemsList,
    required this.onChanged,
    this.hintText,
    this.errorText,
    this.initialValue,
    this.height,
    this.width,
    this.margin,
    this.isLastItemHighlighted = false,
     this.isDense = false,
  }) : super(key: key);

  @override
  State<AppDropDownField> createState() => _AppDropDownFieldState();
}

class _AppDropDownFieldState extends State<AppDropDownField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      margin: widget.margin,
      child: DropdownButtonFormField<String>(
        menuMaxHeight: ScreenUtil.screenHeight * .30,
        isExpanded: true,
        //value: "A",
        value: widget.initialValue,
        // decoration
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.black,

          // to decrease the height size
          isDense: widget.isDense,
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),

          // hint text style
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: AppColor.white),

          // error text
          errorText: widget.errorText,
          errorStyle: const TextStyle(
            color: AppColor.geeBung,
            fontWeight: FontWeight.normal,
          ),

          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColor.black.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.black),
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.red),
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.geeBung),
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
          ),
        ),

        // iconEnabledColor
        iconEnabledColor: AppColor.white,

        // text style
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppColor.white),

        // dropdownColor
        dropdownColor: AppColor.fadeBlack,

        // dropDownRadius
        borderRadius: BorderRadius.all(
          Radius.circular(AppUtils.cornerRadius.w),
        ),

        // onChanged
        onChanged: widget.onChanged,

        validator: (value) {
          // if (value == null) return "* اختر المحافظة محل العمل";
          // if (value.isEmpty) return "* اختر المحافظة محل العمل";
          if (value == null) return "* مطلوب ادخاله";
          if (value.isEmpty) return "* مطلوب ادخاله";
        },
        // items
        items: _items(),
      ),
    );
  }

  List<DropdownMenuItem<String>> _items() {
    final List<DropdownMenuItem<String>> items = [];
    widget.itemsList.asMap().forEach((index, element) {
      items.add(DropdownMenuItem<String>(
        value: element,
        alignment:
            widget.isLastItemHighlighted && index == widget.itemsList.length - 1
                ? AlignmentDirectional.center
                : AlignmentDirectional.centerStart,
        child:
            widget.isLastItemHighlighted && index == widget.itemsList.length - 1
                ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.geeBung,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      element,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Text(element),
      ));
    });
    return items;
  }
}
