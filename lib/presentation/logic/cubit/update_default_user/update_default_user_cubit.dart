import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/data/params/update_user_avatar.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/update_user_after_registration_params.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';
import 'package:remax_mapstate/domain/use_cases/update_user/add_or_remove_fav_project_case.dart';
import 'package:remax_mapstate/domain/use_cases/update_user/update_user_after_registration.dart';

import '../../../../data/params/add_or_remove_project_to_fav_params.dart';
import '../../../../domain/use_cases/update_user/update_user_avatar.dart';

part 'update_default_user_state.dart';

class UpdateDefaultUserCubit extends Cubit<UpdateDefaultUserState> {
  UpdateDefaultUserCubit() : super(UpdateDefaultUserInitial());

  /// updateDefaultUser
  // void updateDefaultUser({
  //   required String email,
  //   required String firstName,
  //   required String phoneNumber,
  //   required String password,
  //   required UserType currentUserType,
  // }) async {
  //   emit(LoadingToUpdateDefaultUser());
  //
  //   // init params
  //   final params = UpdateDefaultUserParams(
  //     firstName: firstName,
  //     phoneNumber: phoneNumber,
  //     email: email,
  //     password: password,
  //     groupId: currentUserType.convertToGroupId(),
  //   );
  //
  //   // init useCase
  //   final useCase = getItInstance<UpdateDefaultUserCase>();
  //
  //   // fetch unit type names
  //   final either = await useCase(params);
  //
  //   either.fold(
  //     //==> error
  //     (appError) => _emitError(appError),
  //
  //     //==> success
  //     (userEntity) {
  //       userEntity.userType = currentUserType;
  //       _emitIfNotClosed(SuccessUpdateDefaultUser(
  //         userEntity: userEntity,
  //       ));
  //     },
  //   );
  // }

  /// to update the user with required data after
  /// a successfully registration process
  void updateDefaultUserWithDataAfterRegistration({
    required String userId,
    required UserType currentUserType,
    required String userToken,
    required String firstName,
    required String phoneNumber,
  }) async {
    emit(LoadingToUpdateDefaultUser());

    // init params
    final params = UpdateUserGroupParams(
        userId: int.tryParse(userId) ?? -1,
        userGroup: currentUserType.convertToGroupId(),
        firstName: firstName,
        phoneNumber: phoneNumber,
        userToken: userToken);

    // init useCase
    final useCase = getItInstance<UpdateUserAfterRegistrationCase>();

    // fetch unit type names
    final either = await useCase(params);

    either.fold(
      //==> error
      (appError) => _emitError(appError),

      //==> success
      (userEntity) {
        userEntity.userType = currentUserType;
        _emitIfNotClosed(SuccessUpdateDefaultUser(
          userEntity: userEntity,
        ));
      },
    );
  }

  /// to update  current user avatar
  void updateDefaultUserAvatar({
    required String userId,
    required String userToken,
    required String imgPath,
  }) async {
    emit(LoadingToUpdateDefaultUser());

    // init params
    final params = UpdateUserAvatarParams(
      userId: int.tryParse(userId) ?? -1,
      userToken: userToken,
      imgPath: imgPath,
    );

    // init useCase
    final useCase = getItInstance<UpdateUserAvatarCase>();

    // fetch unit type names
    final either = await useCase(params);

    either.fold(
      //==> error
      (appError) => _emitError(appError),

      //==> success
      (userEntity) {
        _emitIfNotClosed(SuccessUpdateDefaultUser(
          userEntity: userEntity,
        ));
      },
    );
  }

  /// to update current user fav projects
  void updateFavoriteProjects({
    required String userId,
    required String userToken,
    required String projectId,
    required bool addToFavorite,
  }) async {
    emit(LoadingToUpdateDefaultUser());

    // init params
    final params = AddOrRemoveFavProjectParam(
        userId: int.tryParse(userId) ?? -1,
        userToken: userToken,
        projectId: projectId,
        addToFavorite: addToFavorite);

    // init useCase
    final useCase = getItInstance<AddOrRemoveFavProjectCase>();

    // fetch unit type names
    final either = await useCase(params);

    either.fold(
      //==> error
      (appError) => _emitError(appError),

      //==> success
      (_) {
        if (addToFavorite) {
          _emitIfNotClosed(NewFavoriteProjectAdded());
        } else {
          _emitIfNotClosed(FavoriteProjectRemoved());
        }
      },
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.emailAlreadyExists) {
      _emitIfNotClosed(UpdateDefaultUserEmailAlreadyExists());
    } else if (appError.appErrorType == AppErrorType.passwordIsMissing) {
      _emitIfNotClosed(UpdateDefaultUserPasswordIsMissing());
    } else {
      _emitIfNotClosed(ErrorWhileUpdatingDefaultUser(appError: appError));
    }
  }

  /// emit if not closed
  void _emitIfNotClosed(UpdateDefaultUserState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
