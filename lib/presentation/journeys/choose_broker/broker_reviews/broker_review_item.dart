import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/domain/entities/BrokerReviewEntity.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import '../../../../common/constants/sizes.dart';
import '../../../themes/theme_color.dart';

class BrokerReviewItem extends StatelessWidget {
  final BrokerReviewEntity reviewEntity;

  const BrokerReviewItem({
    Key? key,
    required this.reviewEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingBar.builder(
              initialRating: reviewEntity.rating.toDouble(),
              minRating: 1,
              itemSize: Sizes.dimen_12.w,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
              unratedColor: AppColor.absoluteTransparentGeeBung,
              ignoreGestures: true,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            Text(
              reviewEntity.review,
              style: Theme.of(context).textTheme.boldVulcanBodyText2.copyWith(
                  // color: AppColor.black,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
