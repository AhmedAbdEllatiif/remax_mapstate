import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

class BrokerDataWidget extends StatelessWidget {
  final String dataKey;
  final dynamic value;
  final bool isRating;

  const BrokerDataWidget(
      {Key? key,
      required this.dataKey,
      required this.value,
      this.isRating = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          dataKey,
          style: Theme.of(context).textTheme.caption!.copyWith(
            color: AppColor.absoluteTransparentGeeBung
          ),
        ),
        isRating
            ? RatingBar.builder(
                initialRating: value,
                minRating: 1,
                itemSize: Sizes.dimen_20.w,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                unratedColor: AppColor.absoluteTransparentGeeBung,
                ignoreGestures: true,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
            : Text(
                value,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppColor.geeBung,
                  fontWeight: FontWeight.w700
                ),
              ),
      ],
    );
  }
}
