import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/params/contact_developer.dart';
import 'package:remax_mapstate/presentation/journeys/developer_contact/developer_contact_image.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/screen_utils/screen_util.dart';
import '../../logic/cubit/developer_contact/developer_contact_cubit.dart';
import 'contact_data_card.dart';

class DeveloperContactScreen extends StatefulWidget {
  final ContactDeveloperParam developerContactParams;

  const DeveloperContactScreen({Key? key, required this.developerContactParams})
      : super(key: key);

  @override
  _DeveloperContactScreenState createState() => _DeveloperContactScreenState();
}

class _DeveloperContactScreenState extends State<DeveloperContactScreen> {
  late final DeveloperContactCubit _developerContactCubit;

  @override
  void initState() {
    super.initState();
    _developerContactCubit = getItInstance<DeveloperContactCubit>();
    _developerContactCubit.loadDeveloperData(
      ContactDeveloperParam(
          developerId: widget.developerContactParams.developerId),
    );
  }

  @override
  void dispose() {
    _developerContactCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _developerContactCubit,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.developerContactParams.name),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: BlocBuilder<DeveloperContactCubit, DeveloperContactState>(
              builder: (context, state) {
                print("DeveloperContactScreen >> $state");

                /// loading
                if (state is LoadingDeveloperContactState) {
                  return const Center(
                    child: LoadingWidget(),
                  );
                }

                /// error
                if (state is DeveloperContactErrorState) {
                  return Center(
                    child: Text(
                      "Error: ${state.appError.appErrorType} , message: ${state.appError.message}",
                    ),
                  );
                }

                /// With image
                if (state is DeveloperContactDataLoadedWithImage) {
                  final developerData = state.contactDeveloperEntity;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil.screenWidth * 0.1,vertical: Sizes.dimen_4.h),
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
                              imageUrl: developerData.image!),
                        ),

                        /// contact data card
                        ContactDataCard(
                          contactDeveloperEntity: state.contactDeveloperEntity,
                        )
                      ],
                    ),
                  );
                }

                /// Without image
                if (state is DeveloperContactDataWithOutImage) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil.screenWidth * 0.1,vertical: Sizes.dimen_4.h),
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
                          child: Image.asset(AssetsConstants.personPlaceHolder),
                        ),
                        ContactDataCard(
                          contactDeveloperEntity: state.contactDeveloperEntity,
                        ),
                      ],
                    ),
                  );
                }

                /// Nothing to show
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
