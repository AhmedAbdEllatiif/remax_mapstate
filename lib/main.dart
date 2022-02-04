import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/git_it.dart' as getIt;

import 'di/git_it.dart';
import 'presentation/bloc/navigation_bloc/navigation_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(getIt.init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => getItInstance<NavigationCubit>(),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () => BlocProvider.of<NavigationCubit>(context).home(),
                  child: const Text("Home"),
                ),

                TextButton(
                  onPressed: () =>
                      BlocProvider.of<NavigationCubit>(context).support(),
                  child: const Text("Support"),
                ),


                TextButton(
                  onPressed: () =>
                      BlocProvider.of<NavigationCubit>(context).calculator(),
                  child: const Text("Calculator"),
                ),

                TextButton(
                  onPressed: () =>
                      BlocProvider.of<NavigationCubit>(context).profile(),
                  child: const Text("Profile"),
                ),

                TextButton(
                  onPressed: () =>
                      BlocProvider.of<NavigationCubit>(context).favorite(),
                  child: const Text("Favorite"),
                ),
              ],
            ),


            BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) {
                return Text(
                  state.props[0].toString(),
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline4,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
