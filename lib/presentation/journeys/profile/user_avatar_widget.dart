import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../../di/git_it.dart';
import '../../logic/cubit/pick_images/pick_image_cubit.dart';
import '../../logic/cubit/update_default_user/update_default_user_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/image_name_rating_widget.dart';

class UserAvatarWidget extends StatefulWidget {
  final UpdateDefaultUserCubit updateDefaultUserCubit;
  final String userId;
  final String userName;
  final String avatarUrl;
  final double rating;
  final bool showRating;

  const UserAvatarWidget({
    Key? key,
    required this.updateDefaultUserCubit,
    required this.userName,
    required this.avatarUrl,
    required this.rating,
    required this.userId,
     this.showRating = true,
  }) : super(key: key);

  @override
  State<UserAvatarWidget> createState() => _UserAvatarWidgetState();
}

class _UserAvatarWidgetState extends State<UserAvatarWidget> {
  String _avatarUrl = "";
  String _pickedImage = "";

  // pick image cubit
  late final PickImageCubit _pickImageCubit;
  late final UpdateDefaultUserCubit _updateDefaultUserCubit;

  @override
  void initState() {
    super.initState();
    _pickImageCubit = getItInstance<PickImageCubit>();
    _updateDefaultUserCubit = widget.updateDefaultUserCubit;
    _avatarUrl = widget.avatarUrl;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => _pickImageCubit)],
      child: BlocListener<PickImageCubit, PickImageState>(
        listener: (context, state) {
          if (state is ImagePicked) {
            _pickedImage = state.image.path;
            _uploadImage();
            print("ImagePicked >> ${state.image.path}");
          }
        },
        child: BlocConsumer<UpdateDefaultUserCubit, UpdateDefaultUserState>(
          bloc: _updateDefaultUserCubit,
          listener: (context, state) {
            if (state is SuccessUpdateDefaultUser) {
              setState(() {
                _avatarUrl = state.userEntity.avatar;
              });
            }
          },
          builder: (context, state) {
            if (state is LoadingToUpdateDefaultUser) {
              return const Center(
                child: LoadingWidget(),
              );
            }

            return ImageNameRatingWidget(
              imgUrl: _avatarUrl,
              name: widget.userName,
              onPressed: () {
                _pickImageCubit.pickSingleImage();
              },

              nameStyle: Theme.of(context).textTheme.headline6!.copyWith(
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
              rating: widget.rating,
            );
          },
        ),
      ),
    );
  }

  void _pickImage() {
    _pickImageCubit.pickSingleImage();
  }

  void _uploadImage() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _updateDefaultUserCubit.updateDefaultUserAvatar(
      userId: widget.userId,
      userToken: userToken,
      imgPath: _pickedImage,
    );
  }
}
