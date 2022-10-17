import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/filter_data_entity.dart';
import 'package:remax_mapstate/domain/use_cases/get_filter_data.dart';

import '../../../../common/enums/app_language.dart';
import '../../../../data/params/filter_data_params.dart';
import '../language/language_cubit.dart';

part 'get_filter_data_state.dart';

class GetFilterDataCubit extends Cubit<GetFilterDataState> {
  GetFilterDataCubit() : super(GetFilterDataInitial());

  void fetchFilterData(BuildContext context,
      {required String userToken}) async {
    //==> emit loading
    _emitIfNotClosed(LoadingGetFilterData());

    //==> useCase
    final useCase = getItInstance<GetFilterDataCase>();

    // init current language
    final languageCode = context.read<LanguageCubit>().state.languageCode;
    final appLanguage = languageCode == "en" ? AppLanguage.en : AppLanguage.ar;

    // init params
    final params =
        FilterDataParams(appLanguage: appLanguage, userToken: userToken);

    final response = await useCase(params);

    response.fold(
      // error
      (appError) =>
          _emitIfNotClosed(ErrorWhileGettingFilterData(appError: appError)),

      // fetched
      (filterDataEntity) => _emitIfNotClosed(
          FilterDataFetched(filterDataEntity: filterDataEntity)),
    );
  }

  /// emit if not closed
  void _emitIfNotClosed(GetFilterDataState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
