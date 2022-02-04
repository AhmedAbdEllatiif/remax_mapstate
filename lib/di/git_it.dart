import 'package:get_it/get_it.dart';
import 'package:remax_mapstate/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/navigation_bloc/navigation_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {


  // init navigation cubit
  getItInstance.registerFactory<NavigationCubit>(() => NavigationCubit());

  ///**********************************init blocs*********************************************\\\
  // init LanguageBloc
  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc());

}