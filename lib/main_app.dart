import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/language_constants.dart';
import 'package:remax_mapstate/common/constants/route_list.dart';
import 'package:remax_mapstate/common/enums/login_status.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/presentation/app_localization.dart';
import 'package:remax_mapstate/presentation/cubit/auto_login/auto_login_cubit.dart';
import 'package:remax_mapstate/presentation/cubit/language/language_cubit.dart';
import 'package:remax_mapstate/router/fade_page_route.dart';
import 'package:remax_mapstate/router/routes.dart';
import 'common/constants/sizes.dart';
import 'presentation/cubit/current_user/current_user_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

class MainApp extends StatefulWidget {
  final UserType userType;
  final CurrentUserCubit currentUserCubit;
  final LanguageCubit languageCubit;
  final AutoLoginCubit autoLoginCubit;

  const MainApp(
      {Key? key,
      required this.currentUserCubit,
      required this.userType,
      required this.languageCubit,
      required this.autoLoginCubit})
      : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();

    /// loadCurrentUser of currentUserCubit
    widget.currentUserCubit.loadCurrentUser();

    ///init screen util
    ScreenUtil.init();
  }

  @override
  void dispose() {
    widget.currentUserCubit.close();
    widget.languageCubit.close();
    widget.autoLoginCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>.value(value: widget.languageCubit),
        BlocProvider<CurrentUserCubit>.value(value: widget.currentUserCubit),
        BlocProvider<AutoLoginCubit>.value(value: widget.autoLoginCubit),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (_, locale) {
          return BlocBuilder<AutoLoginCubit, AutoLoginState>(
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
                  unselectedWidgetColor:  AppColor.geeBung,
                  primaryColor: AppColor.black,
                  colorScheme: ColorScheme.fromSwatch().copyWith(
                    secondary: AppColor.geeBung, // Your accent color
                  ),
                  scaffoldBackgroundColor: AppColor.black,
                  textTheme: ThemeText.getTextTheme(),
                  appBarTheme: const AppBarTheme(
                    centerTitle: true,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      // Status bar color
                      //statusBarColor: AppColor.bgGray,


                      // Status bar brightness (optional)
                      // statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
                      // statusBarBrightness: Brightness.light, // For iOS (dark icons)
                    ),
                    iconTheme: IconThemeData(color: AppColor.geeBung),
                    elevation: 0,
                    titleTextStyle: TextStyle(
                      color: AppColor.geeBung,
                      fontSize: Sizes.dimen_18,
                      fontWeight: FontWeight.bold,
                    ),
                    color: AppColor.fadeBlack,
                  ),
                ),

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
                initialRoute: autoLoginState.loginStatus == LoginStatus.loggedIn
                    ? RouteList.mainScreen
                    : RouteList.chooseUserScreen,
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
}
