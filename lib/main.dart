import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:remax_mapstate/data/tables/current_user_table.dart';
import 'package:remax_mapstate/data/tables/fav_project_table.dart';
import 'package:remax_mapstate/main_app.dart';
import 'package:remax_mapstate/presentation/cubit/navigation/navigation_cubit.dart';
import 'package:remax_mapstate/presentation/journeys/drawer/navigation_drawer.dart';
import 'di/git_it.dart' as getIt;
import 'package:path_provider/path_provider.dart' as path_provider;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set orientation
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));

  // init getIt
  unawaited(getIt.init());

  // init appDocumentDir
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(FavProjectTableAdapter());
  Hive.registerAdapter(CurrentUserTableAdapter());

  runApp(const MainApp());
}

