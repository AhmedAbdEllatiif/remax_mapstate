import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:remax_mapstate/data/params/make_call_params.dart';
import 'package:remax_mapstate/data/params/open_map_params.dart';
import 'package:remax_mapstate/data/params/whatsapp_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';

import '../../../../domain/use_cases/make_phone_call.dart';
import '../../../../domain/use_cases/open_map.dart';
import '../../../../domain/use_cases/open_whats_app.dart';

part 'launch_apps_event.dart';

part 'launch_apps_state.dart';

class LaunchAppsBloc extends Bloc<LaunchAppsEvent, LaunchAppsState> {
  final OpenWhatsappCase openWhatsappCase;
  final OpenMapCase openMapCase;
  final MakePhoneCallCase makePhoneCallCase;

  LaunchAppsBloc({
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
        * open whats app
        *
        *
        * */
        if (event is OpenWhatsAppEvent) {
          //==> emit loading launch map
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
        * open whats app
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
          //==> emit loading launch map
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
