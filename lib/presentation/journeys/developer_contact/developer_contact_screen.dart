import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/params/contact_developer.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/presentation/journeys/developer_contact/developer_contact_image.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/screen_utils/screen_util.dart';
import '../../logic/cubit/developer_contact/developer_contact_cubit.dart';
import '../../widgets/stack_with_full_background.dart';
import 'contact_data_card.dart';

class DeveloperContactScreen extends StatefulWidget {
  final ContactDeveloperParam developerContactParams;

  const DeveloperContactScreen({Key? key, required this.developerContactParams})
      : super(key: key);

  @override
  _DeveloperContactScreenState createState() => _DeveloperContactScreenState();
}

class _DeveloperContactScreenState extends State<DeveloperContactScreen> {
  late final DeveloperEntity _developerEntity;

  late final bool _isContactHasImage;

  late final DeveloperContactEntity _developerContactEntity;

  @override
  void initState() {
    super.initState();
    _developerEntity = widget.developerContactParams.developerEntity;

    _developerContactEntity =
        widget.developerContactParams.developerEntity.developerContactEntity;

    _isContactHasImage =
        _developerContactEntity.profileImage != AppUtils.undefined;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StackScaffoldWithFullBackground(
      appBarTitle: Text(_developerEntity.name),
      body: Center(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: _isContactHasImage
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil.screenWidth * 0.1,
                        vertical: Sizes.dimen_4.h),
                    child: Column(
                      children: [
                        /// image
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: ScreenUtil.screenHeight * 0.35,
                            maxWidth: ScreenUtil.screenWidth * 0.7,
                            minHeight: ScreenUtil.screenHeight * 0.35,
                            minWidth: ScreenUtil.screenWidth * 0.7,
                          ),
                          margin: EdgeInsets.only(bottom: Sizes.dimen_10.h),
                          child: DeveloperContactImage(
                            imageUrl: _developerContactEntity.profileImage,
                          ),
                        ),

                        /// contact data card
                        ContactDataCard(
                          developerContactEntity: _developerContactEntity,
                          developerName: _developerEntity.name,
                          locationEntity: _developerEntity.locationEntity,
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil.screenWidth * 0.1,
                        vertical: Sizes.dimen_4.h),
                    child: Column(
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: ScreenUtil.screenHeight * 0.25,
                            maxWidth: ScreenUtil.screenWidth * 0.7,
                            minHeight: ScreenUtil.screenHeight * 0.25,
                            minWidth: ScreenUtil.screenWidth * 0.7,
                          ),
                          margin: EdgeInsets.only(bottom: Sizes.dimen_10.h),
                          child: Image.asset(
                            AssetsConstants.personPlaceHolder,
                            color: AppColor.white.withOpacity(0.6),
                          ),
                        ),
                        ContactDataCard(
                          developerContactEntity: _developerContactEntity,
                          developerName: _developerEntity.name,
                          locationEntity: _developerEntity.locationEntity,
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }
}
