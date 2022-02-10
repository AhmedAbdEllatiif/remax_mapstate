import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/avatar_name_section.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/expansion_item.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/layout_section.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/overview_section.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_data_item_card.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_details_argument.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_images_section.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_section.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/services.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/starting_price_section.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/submit_inquiry_button.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final ProjectDetailsArgument projectDetailsArgument;

  const ProjectDetailsScreen({Key? key, required this.projectDetailsArgument})
      : super(key: key);

  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(TranslateConstants.projectDetails.t(context)),
        ),
        body: Stack(
          children: [
            Scrollbar(
              radius: const Radius.circular(Sizes.dimen_60),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    /// Project Images section
                    ProjectImagesSection(),

                    /// Project avatar, name, isFavorite, district
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_16.w,
                          vertical: Sizes.dimen_12.w),
                      child: const ProjectAvatarNameSection(
                        name: '',
                        district: '',
                        avatarUrl: '',
                      ),
                    ),

                    /// Starting price section
                    const ProjectStartingPriceSection(
                      startingPrice: '',
                    ),

                    /// projectData paymentPlan, startingArea, FinishingType, DeliveryYear
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_32.w,
                          vertical: Sizes.dimen_12.w),
                      child: const ProjectDataSection(
                        deliveryYear: '',
                        startingArea: '',
                        paymentPlan: '',
                        finishingType: '',
                      ),
                    ),

                    /// Services section
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_10.w,
                          vertical: Sizes.dimen_12.w),
                      child: const ServicesSection(),
                    ),

                    /// overView and layout section
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_16.w,
                          vertical: Sizes.dimen_12.w),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: Sizes.dimen_10.w,
                          right: Sizes.dimen_10.w,
                          top: Sizes.dimen_8.w,
                          bottom: Sizes.dimen_30.w,
                        ),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            /// overview section
                            OverViewSection(),

                            /// layout section
                            LayoutSection(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Submit Inquiry Button
            Positioned(
              bottom: 0.0,
              right: 0.0,
              left: 0.0,
              child: SubmitInquiryButton(
                onPressed: () {},
              ),
            ),
          ],
        ));
  }
}
