import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:remax_mapstate/data/tables/current_user_table.dart';
import 'package:remax_mapstate/data/tables/fav_project_table.dart';
import 'package:remax_mapstate/main_app.dart';
import 'package:remax_mapstate/presentation/logic/cubit/auto_login/auto_login_cubit.dart';
import 'package:remax_mapstate/presentation/logic/cubit/current_user/current_user_cubit.dart';
import 'package:remax_mapstate/presentation/logic/cubit/language/language_cubit.dart';
import 'di/git_it.dart' as getIt;
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set orientation
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));

  // init getIt
  //unawaited(getIt.init());
  await getIt.init();
  final CurrentUserCubit currentUserCubit =
      getIt.getItInstance<CurrentUserCubit>();
  final LanguageCubit languageCubit = getIt.getItInstance<LanguageCubit>();
  final AutoLoginCubit autoLoginCubit = getIt.getItInstance<AutoLoginCubit>();

  // init appDocumentDir
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(FavProjectTableAdapter());
  Hive.registerAdapter(CurrentUserTableAdapter());

  final currentUserType = await currentUserCubit.getCurrentUserType();
  await languageCubit.loadPreferredLanguage();
  await autoLoginCubit.loadCurrentAutoLoginStatus();

  runApp(MainApp(
    languageCubit: languageCubit,
    currentUserCubit: currentUserCubit,
    userType: currentUserType,
    autoLoginCubit: autoLoginCubit,
  ));
}
