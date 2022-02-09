import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/language_constants.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/presentation/app_localization.dart';
import 'package:remax_mapstate/router/app_router.dart';
import 'presentation/cubit/current_user/current_user_cubit.dart';
import 'package:remax_mapstate/presentation/journeys/main/main_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';
import 'di/git_it.dart';
import 'presentation/bloc/language_bloc/language_bloc.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late LanguageBloc _languageBloc;
  late CurrentUserCubit _currentUserCubit;
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();

    _appRouter = getItInstance<AppRouter>();


    _languageBloc = getItInstance<LanguageBloc>();
    _currentUserCubit = getItInstance<CurrentUserCubit>();
    //init screen util
    ScreenUtil.init();

  }

  @override
  void dispose() {
    _languageBloc.close();
    _currentUserCubit.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>.value(value: _languageBloc),
        BlocProvider<CurrentUserCubit>.value(value: _currentUserCubit)
      ],
           child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state is LanguageChanged) {
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

              theme: ThemeData(
                unselectedWidgetColor: AppColor.royalBlue,
                primaryColor: AppColor.vulcan,
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  secondary: AppColor.royalBlue, // Your accent color
                ),
                scaffoldBackgroundColor: AppColor.vulcan,
                textTheme: ThemeText.getTextTheme(),
                appBarTheme: const AppBarTheme(elevation: 0,color: AppColor.vulcan,),
              ),

              supportedLocales: LanguageConstants.supportedLanguages
                  .map((e) => Locale(e.code))
                  .toList(),
              locale: state.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              initialRoute: AppRouter.mainScreen,
              onGenerateRoute: _appRouter.onGeneratedRoute,
            );
          }
          return const Text("No Language provided");
        },
      ),
    );
  }
}
