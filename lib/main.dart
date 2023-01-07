import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:remax_mapstate/data/tables/fav_project_table.dart';
import 'package:remax_mapstate/main_app.dart';
import 'package:remax_mapstate/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:remax_mapstate/presentation/logic/cubit/language/language_cubit.dart';
import 'package:remax_mapstate/presentation/logic/cubit/user_token/user_token_cubit.dart';
import 'di/git_it.dart' as getIt;
import 'package:path_provider/path_provider.dart' as path_provider;

import 'di/git_it.dart';
import 'firebase_options.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set orientation
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));

  /// initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // init getIt
  //unawaited(getIt.init());
  await getIt.init();
  final AuthorizedUserCubit authorizedUserCubit =
      getIt.getItInstance<AuthorizedUserCubit>();
  final LanguageCubit languageCubit = getIt.getItInstance<LanguageCubit>();
  final UserTokenCubit userTokenCubit = getIt.getItInstance<UserTokenCubit>();

  // init appDocumentDir
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(FavProjectTableAdapter());

  final authorizedUser =
      await authorizedUserCubit.loadCurrentAuthorizedUserData();
  await languageCubit.loadPreferredLanguage();
  await userTokenCubit.loadCurrentAutoLoginStatus();

  /// to setup firebase messaging
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  _setupFCM();

  runApp(MainApp(
    languageCubit: languageCubit,
    authorizedUserCubit: authorizedUserCubit,
    userTokenCubit: userTokenCubit,
  ));
}

/// To setup FCm
///
/// Set the background messaging handler early on, as a named top-level function
/// init flutter notification plugin
Future<void> _setupFCM() async {
  /// Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    /// init default android notification channel
    channel = getItInstance<AndroidNotificationChannel>();

    /// init flutter notification plugin
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
