import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/avatar_name_section.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/layout_section.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/overview_section.dart';

import 'package:remax_mapstate/presentation/arguments/project_details_argument.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_images_section.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_section.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/services.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/starting_price_section.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

import 'buttons_section.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final ProjectDetailsArgument projectDetailsArgument;

  const ProjectDetailsScreen({Key? key, required this.projectDetailsArgument})
      : super(key: key);

  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {

  late final ProjectEntity projectEntity;


  @override
  void initState() {
    super.initState();
    projectEntity = widget.projectDetailsArgument.projectEntity;
  }

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
                      child:  ProjectAvatarNameSection(
                        name: projectEntity.name,
                        region: projectEntity.region,
                        zone: projectEntity.zone,
                        avatarUrl: projectEntity.developer.logoFullPath,
                      ),
                    ),

                    /// Starting price section
                     ProjectStartingPriceSection(
                      startingPrice: projectEntity.formattedStartingPrice,
                    ),

                    /// projectData paymentPlan, startingArea, FinishingType, DeliveryYear
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_32.w,
                          vertical: Sizes.dimen_12.w),
                      child:  ProjectDataSection(
                        deliveryYear: projectEntity.deliveryYear,
                        startingArea: projectEntity.areaFrom,
                        planPercentage: projectEntity.planPercentage.toString(),
                        planYears: projectEntity.planNumberOfYears.toString(),
                        finishingType: '',
                      ),
                    ),

                    /// Services section
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_10.w,
                          vertical: Sizes.dimen_12.w),
                      child:  ServicesSection(services: projectEntity.services,),
                    ),

                    /// overView and layout section
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_16.w,
                          vertical: Sizes.dimen_12.w),
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: Sizes.dimen_22.h,
                        ),
                        padding: EdgeInsets.only(
                          left: Sizes.dimen_10.w,
                          right: Sizes.dimen_10.w,
                          top: Sizes.dimen_8.w,
                          bottom: Sizes.dimen_40.w,
                        ),
                        color: AppColor.fadeBlack,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            /// overview section
                            OverViewSection(description: projectEntity.description,),

                            /// layout section
                            LayoutSection(unitTypeSets: projectEntity.unitTypeSets,),
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
              child: ButtonSection(developerId: widget.projectDetailsArgument.projectId),
            ),
          ],
        ));
  }

}
