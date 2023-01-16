import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/contact_us_request_params.dart';
import 'package:remax_mapstate/domain/use_cases/contact_us_case.dart';

import '../../../../di/git_it.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());

  /// send contact us
  void sendContactUs({
    required String userToken,
    required String title,
    required String subject,
  }) async {
    // loading
    _emitIfNotClosed(LoadingToSendContactUs());

    // init usecase
    final userCase = getItInstance<ContactUsCase>();

    // init params
    final params = ContactUsRequestParams(
      userToken: userToken,
      title: title,
      subject: subject,
    );

    // send request
    final either = await userCase(params);

    // receive result
    either.fold(
      (appError) {
        _emitIfNotClosed(ErrorWhileSendingContactUs(appError: appError));
      },
      // success
      (_) {
        _emitIfNotClosed(ContactUsSentSuccessfully());
      },
    );
  }

  /// emit if not closed
  void _emitIfNotClosed(ContactUsState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
