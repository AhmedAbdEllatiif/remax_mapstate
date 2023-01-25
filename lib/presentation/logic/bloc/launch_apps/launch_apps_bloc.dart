import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/data/params/make_call_params.dart';
import 'package:remax_mapstate/data/params/open_facebook_params.dart';
import 'package:remax_mapstate/data/params/open_map_params.dart';
import 'package:remax_mapstate/data/params/whatsapp_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/use_cases/launch_apps/launch_facbook_case.dart';

import '../../../../domain/use_cases/make_phone_call.dart';
import '../../../../domain/use_cases/open_map.dart';
import '../../../../domain/use_cases/open_whats_app.dart';

part 'launch_apps_event.dart';

part 'launch_apps_state.dart';

class LaunchAppsBloc extends Bloc<LaunchAppsEvent, LaunchAppsState> {
  final LaunchFacebookCase launchFacebookCase;
  final OpenWhatsappCase openWhatsappCase;
  final OpenMapCase openMapCase;
  final MakePhoneCallCase makePhoneCallCase;

  LaunchAppsBloc({
    required this.launchFacebookCase,
    required this.openWhatsappCase,
    required this.openMapCase,
    required this.makePhoneCallCase,
  }) : super(LaunchAppsInitial()) {
    on<LaunchAppsEvent>(
      (event, emit) async {
        /// emit if not closed
        void _emitIfNotClosed(LaunchAppsState state) {
          if (!isClosed) {
            emit(state);
          }
        } // end of _emitIfNotClosed

        /*
        *
        *
        * open facebook
        *
        *
        * */
        if (event is OpenFacebookEvent) {
          //==> emit loading launch facebook
          _emitIfNotClosed(LoadingToOpenFacebook());

          final either = await launchFacebookCase(event.openFaceBookParams);
          either.fold(
            // error
            (appError) => _emitIfNotClosed(
              ErrorWhileOpenFacebook(
                openFaceBookParams: event.openFaceBookParams,
                appError: appError,
              ),
            ),

            // success
            (success) => _emitIfNotClosed(SuccessToLaunchApp()),
          );
        }

        /*
        *
        *
        * open whats app
        *
        *
        * */
        if (event is OpenWhatsAppEvent) {
          //==> emit loading launch whatsapp
          _emitIfNotClosed(LoadingToLaunchWhatsapp());

          final either = await openWhatsappCase(event.whatsappParams);
          either.fold(
            // error
            (appError) => _emitIfNotClosed(
              ErrorWhileOpenWhatsApp(
                whatsappParams: event.whatsappParams,
                appError: appError,
              ),
            ),

            // success
            (success) => _emitIfNotClosed(SuccessToLaunchApp()),
          );
        }

        /*
        *
        *
        * open map
        *
        *
        * */
        if (event is OpenMapEvent) {
          //==> emit loading launch map
          _emitIfNotClosed(LoadingToLaunchMap());

          final either = await openMapCase(event.openMapParams);
          either.fold(
            // error
            (appError) => _emitIfNotClosed(
              ErrorWhileOpenMap(
                openMapParams: event.openMapParams,
                appError: appError,
              ),
            ),

            // success
            (success) => _emitIfNotClosed(SuccessToLaunchApp()),
          );
        }

        /*
        *
        *
        * make a call
        *
        *
        * */
        if (event is MakeACallEvent) {
          //==> emit loading make a call
          _emitIfNotClosed(LoadingToMakeACall());

          final either = await makePhoneCallCase(event.makeCallParams);
          either.fold(
            // error
            (appError) => _emitIfNotClosed(
              ErrorWhileMakeACall(
                makeCallParams: event.makeCallParams,
                appError: appError,
              ),
            ),

            // success
            (success) => _emitIfNotClosed(SuccessToLaunchApp()),
          );
        }
      },
    ); // on<LaunchAppsEvent>
  }
}
