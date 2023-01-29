import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/domain/entities/authorized_user_entity.dart';
import 'package:remax_mapstate/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';

AuthorizedUserEntity getAuthorizedUser(BuildContext context) {
  return context.read<AuthorizedUserCubit>().state.authorizedUserEntity;
}
