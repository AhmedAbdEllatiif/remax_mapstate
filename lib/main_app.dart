import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/language_constants.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/presentation/app_localization.dart';
import 'package:remax_mapstate/presentation/cubit/language/language_cubit.dart';
import 'package:remax_mapstate/router/app_router.dart';
import 'presentation/cubit/current_user/current_user_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';
import 'di/git_it.dart';

import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

class MainApp extends StatefulWidget {

  final UserType userType;
  final CurrentUserCubit currentUserCubit;

    const MainApp({Key? key, required this.currentUserCubit,required this.userType}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late LanguageCubit _languageCubit;
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();

    _appRouter = getItInstance<AppRouter>();

    /// init language bloc
    _languageCubit = getItInstance<LanguageCubit>();
    _languageCubit.loadPreferredLanguage();

    /// loadCurrentUser of currentUserCubit
    widget.currentUserCubit.loadCurrentUser();

    ///init screen util
    ScreenUtil.init();
  }

  @override
  void dispose() {
    widget.currentUserCubit.close();
    _languageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>.value(value: _languageCubit),
        BlocProvider<CurrentUserCubit>.value(value: widget.currentUserCubit)
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
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
              unselectedWidgetColor: AppColor.royalBlue,
              primaryColor: AppColor.vulcan,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: AppColor.royalBlue, // Your accent color
              ),
              scaffoldBackgroundColor: AppColor.vulcan,
              textTheme: ThemeText.getTextTheme(),
              appBarTheme: const AppBarTheme(
                elevation: 0,
                color: AppColor.vulcan,
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
            initialRoute:
            widget.userType == UserType.noUser || widget.userType == UserType.tour
                ? AppRouter.chooseUserScreen
                : AppRouter.mainScreen,
            onGenerateRoute: _appRouter.onGeneratedRoute,
          );
        },
      ),
    );
  }


}
