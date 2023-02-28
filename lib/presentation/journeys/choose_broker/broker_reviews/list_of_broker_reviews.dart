import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/choose_broker/broker_reviews/broker_review_item.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import '../../../../domain/entities/BrokerReviewEntity.dart';
import '../../../themes/theme_color.dart';

class ListOfBrokerReviews extends StatelessWidget {
  final List<BrokerReviewEntity> reviews;

  const ListOfBrokerReviews({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          TranslateConstants.reviews.t(context) + " (${reviews.length})",
          style: Theme.of(context)
              .textTheme
              .geryCaption
              .copyWith(color: AppColor.black.withOpacity(0.6)),
        ),

        /// reviews
        reviews.isEmpty
            ? Center(
                child: Text(
                  TranslateConstants.notReviewedYet.t(context),
                  style:
                      Theme.of(context).textTheme.boldVulcanBodyText2.copyWith(
                          // color: AppColor.black,
                          fontWeight: FontWeight.w700),
                ),
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  right: 10,
                  left: 10,
                  bottom: 10,
                ),
                //==> itemCount
                itemCount: reviews.length,
                //itemCount: 10,

                //==> separatorBuilder
                separatorBuilder: (_, __) => const SizedBox(height: 1),

                //==> itemBuilder
                itemBuilder: (context, index) {
                  return BrokerReviewItem(reviewEntity: reviews[index]);
                  // return BrokerReviewItem(
                  //     reviewEntity:
                  //         BrokerReviewEntity(review: "Awesome broker", rating: 3));
                },
              ),
      ],
    );
  }
}
