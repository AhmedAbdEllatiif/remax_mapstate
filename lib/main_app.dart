import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remax_mapstate/common/constants/language_constants.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/domain/entities/authorized_user_entity.dart';
import 'package:remax_mapstate/presentation/app_localization.dart';
import 'package:remax_mapstate/presentation/journeys/main/main_screen.dart';
import 'package:remax_mapstate/presentation/journeys/choose_user_type/choose_user_screen.dart';
import 'package:remax_mapstate/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:remax_mapstate/presentation/logic/cubit/first_launch/first_launch_cubit.dart';
import 'package:remax_mapstate/presentation/logic/cubit/language/language_cubit.dart';
import 'package:remax_mapstate/presentation/logic/cubit/user_token/user_token_cubit.dart';
import 'package:remax_mapstate/router/fade_page_route.dart';
import 'package:remax_mapstate/router/routes.dart';
import 'common/constants/sizes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'main.dart';

class MainApp extends StatefulWidget {
  final AuthorizedUserCubit authorizedUserCubit;
  final LanguageCubit languageCubit;
  final UserTokenCubit userTokenCubit;
  final FirstLaunchStatusCubit firstLaunchStatusCubit;

  const MainApp({
    Key? key,
    required this.authorizedUserCubit,
    required this.languageCubit,
    required this.userTokenCubit,
    required this.firstLaunchStatusCubit,
  }) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();

    /// loadCurrentUser of currentUserCubit
    widget.authorizedUserCubit.loadCurrentAuthorizedUserData();
    widget.firstLaunchStatusCubit.loadFirstLaunchStatus();
    // widget.authorizedUserCubit.save(AuthorizedUserEntity(
    //     id: "id",
    //     firstName: "firstName",
    //     lastName: "lastName",
    //     email: "email",
    //     phoneNum: "phoneNum",
    //     userType: UserType.client));

    /// interactedMessageWhenAppIsTerminated
    _interactedMessageWhenAppIsTerminated();

    /// setupInteractedMessage
    _interactedMessageWhenAppIsOpenedInBackground();

    /// showReceivedNotification
    _showReceivedNotification();

    ///init screen util
    ScreenUtil.init();
  }

  @override
  void dispose() {
    widget.authorizedUserCubit.close();
    widget.languageCubit.close();
    widget.userTokenCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>.value(value: widget.languageCubit),
        BlocProvider<AuthorizedUserCubit>.value(
            value: widget.authorizedUserCubit),
        BlocProvider<UserTokenCubit>.value(value: widget.userTokenCubit),
        BlocProvider<FirstLaunchStatusCubit>.value(
            value: widget.firstLaunchStatusCubit),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (_, locale) {
          return BlocBuilder<UserTokenCubit, UserTokenState>(
            builder: (_, autoLoginState) {
              return MaterialApp(
                builder: (context, widget) => ResponsiveWrapper.builder(
                    ClampingScrollWrapper.builder(context, widget!),
                    maxWidth: 1200,
                    //minWidth: 480,
                    defaultScale: true,
                    breakpoints: [
                      const ResponsiveBreakpoint.resize(350, name: MOBILE),
                      const ResponsiveBreakpoint.autoScale(600, name: TABLET),
                      const ResponsiveBreakpoint.resize(800, name: DESKTOP),
                      const ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
                      // const ResponsiveBreakpoint.autoScale(500,name: TABLET,scaleFactor: 1)
                    ]),

                /// Theme
                theme: ThemeData(
                    unselectedWidgetColor: AppColor.geeBung,
                    primaryColor: AppColor.black,
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                      secondary: AppColor.geeBung, // Your accent color
                    ),
                    scaffoldBackgroundColor: AppColor.baseBlack,
                    textTheme: ThemeText.getTextTheme(),
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      centerTitle: true,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        // Status bar color
                        statusBarColor: Colors.transparent,

                        // Status bar brightness (optional)
                        statusBarIconBrightness: Brightness.light,
                        // For Android (dark icons)
                        statusBarBrightness:
                            Brightness.light, // For iOS (dark icons)
                      ),
                    ),

                    /// default card theme
                    cardTheme: CardTheme(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(Sizes.dimen_10.w)),
                      ),
                    )),

                /// Languages
                supportedLocales: LanguageConstants.supportedLanguages
                    .map((e) => Locale(e.code))
                    .toList(),
                locale: locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],

                /// Routes
                //initialRoute:RouteList.loginScreen,
                /*initialRoute: autoLoginState.loginStatus == LoginStatus.loggedIn
                    ? RouteList.mainScreen
                    : RouteList.chooseUserScreen,
*/
                home: BlocBuilder<UserTokenCubit, UserTokenState>(
                  builder: (context, state) {
                    if (state.userToken.isNotEmpty) {
                      return const MainScreen();
                    }
                    return const ChooseUserScreen();
                  },
                ),
                onGenerateRoute: (RouteSettings settings) {
                  final routes = Routes.getRoutes(settings);
                  final WidgetBuilder? builder = routes[settings.name];
                  return FadePageRouteBuilder(
                    builder: builder!,
                    settings: settings,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  /// To interact with clicked notification when app is open in background
  Future<void> _interactedMessageWhenAppIsOpenedInBackground() async {
    ///==> Also handle any interaction when the app is in the background via a
    ///==> Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("_interactedMessageWhenAppIsOpenedInBackground");
      // _handleMessage(message);
    });
  }

  /// To interact with clicked notification when app is terminated
  Future<void> _interactedMessageWhenAppIsTerminated() async {
    ///==> Get any messages which caused the application to open from
    ///==> a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    ///==> If the message also contains a data property with a "type" of "chat",
    ///==> navigate to a chat screen
    if (initialMessage != null) {
      print("_interactedMessageWhenAppIsTerminated");
      //_handleMessage(initialMessage);
    }
  }

  /// show received notification banner
  void _showReceivedNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    log("MainApp >> _showReceivedNotification message : $message");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        /// insert into local data base
        // _insertNotificationIntoLocalDB(message);

        /// show notification
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
                visibility: NotificationVisibility.public),
          ),
        );
      }
    });
  }
}
