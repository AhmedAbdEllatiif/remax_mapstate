import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/main_app.dart';
import 'package:remax_mapstate/presentation/cubit/navigation/navigation_cubit.dart';
import 'package:remax_mapstate/presentation/journeys/drawer/navigation_drawer.dart';
import 'di/git_it.dart' as getIt;

import 'di/git_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(getIt.init());
  runApp(const MainApp());
}

