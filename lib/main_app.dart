import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constatns/language_constants.dart';
import 'package:remax_mapstate/presentation/app_localization.dart';
import 'package:remax_mapstate/presentation/journeys/main/main_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'di/git_it.dart';
import 'presentation/bloc/language_bloc/language_bloc.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late LanguageBloc _languageBloc;

  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
    //init screen util
    //ScreenUtil.init();
  }

  @override
  void dispose() {
    _languageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageBloc>.value(
      value: _languageBloc,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state is LanguageChanged) {
            return MaterialApp(
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
              home: const MainScreen(),
            );
          }
          return const Text("No Language provided");
        },
      ),
    );
  }
}
