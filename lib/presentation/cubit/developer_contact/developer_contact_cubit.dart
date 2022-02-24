import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/contact_developer.dart';
import 'package:remax_mapstate/domain/entities/params/contact_developer.dart';
import 'package:remax_mapstate/domain/use_cases/get_developer_contact.dart';

part 'developer_contact_state.dart';

class DeveloperContactCubit extends Cubit<DeveloperContactState> {
  final GetDeveloperContactCase getDeveloperContactCase;

  DeveloperContactCubit({required this.getDeveloperContactCase})
      : super(LoadingDeveloperContactState());

  void _emitIfNotClosed(DeveloperContactState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  void loadDeveloperData(ContactDeveloperParam params) async {
    /// loading
    _emitIfNotClosed(LoadingDeveloperContactState());

    Future.delayed(const Duration(seconds: 3), () async {
      final eitherData = await getDeveloperContactCase(params);
      eitherData.fold(

          /// appError
          (appError) =>
              _emitIfNotClosed(DeveloperContactErrorState(appError: appError)),
          (developerData) {
        if (developerData.image == null) {

          /// without image
          _emitIfNotClosed(DeveloperContactDataWithOutImage(
              contactDeveloperEntity: developerData));
        } else {
          
          /// with image
          _emitIfNotClosed(DeveloperContactDataLoadedWithImage(
              contactDeveloperEntity: developerData));
        }
      });
    });
  }
}
