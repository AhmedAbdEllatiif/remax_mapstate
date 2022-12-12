import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remax_mapstate/common/enums/range_format.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

import '../../common/constants/app_utils.dart';
import '../../common/constants/sizes.dart';
import '../../common/constants/translate_constatns.dart';
import '../themes/theme_color.dart';

class RangeSliderWidget extends StatefulWidget {
  final String title;
  final double start;
  final double end;
  final int? divisions;
  final RangeFormat rangeFormat;
  final Function(RangeValues) onRangeChanged;

  const RangeSliderWidget({
    Key? key,
    required this.title,
    required this.start,
    required this.end,
    required this.onRangeChanged,
    required this.rangeFormat,
    this.divisions,
  }) : super(key: key);

  @override
  State<RangeSliderWidget> createState() => _RangeSliderWidgetState();
}

class _RangeSliderWidgetState extends State<RangeSliderWidget> {
  /// currencyFormat
  var currencyFormat = NumberFormat.currency(
    decimalDigits: 0,
    locale: 'en_US',
    symbol: "",
  );

  /// decimalFormat
  var decimalFormat = NumberFormat.decimalPattern('en_US');

  /// values to change
  late RangeValues _values;

  @override
  void initState() {
    super.initState();
    _values = RangeValues(widget.start, widget.end);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.black,
        borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
      ),
      padding: EdgeInsets.symmetric(
        vertical: Sizes.dimen_5.h,
        horizontal: Sizes.dimen_10.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// title
          Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColor.white),
          ),

          /// range slider
          RangeSlider(
            values: _values,
            min: widget.start,
            max: widget.end,
            divisions: widget.divisions,
            inactiveColor: AppColor.geeBung.withOpacity(0.5),
            activeColor: AppColor.geeBung,
            labels: RangeLabels(
              _values.start.round().toString(),
              _values.end.round().toString(),
            ),
            onChanged: (values) {
              setState(() {
                _values = values;
                widget.onRangeChanged(values);
              });
            },
          ),

          Padding(
            padding: EdgeInsets.only(top: Sizes.dimen_3.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.fadeBlack,
                    borderRadius:
                        BorderRadius.circular(AppUtils.cornerRadius.w),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.rangeFormat == RangeFormat.decimal
                        ? decimalFormat.format(_values.start)
                        : currencyFormat.format(_values.start),
                  ),
                ),
                Text(
                  TranslateConstants.toStr.t(context),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColor.white, fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.fadeBlack,
                    borderRadius:
                        BorderRadius.circular(AppUtils.cornerRadius.w),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.rangeFormat == RangeFormat.decimal
                        ? decimalFormat.format(_values.end)
                        : currencyFormat.format(_values.end),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
