import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/contact_developer.dart';
import 'package:remax_mapstate/domain/entities/params/contact_developer.dart';
import 'package:remax_mapstate/domain/entities/params/phone_call.dart';
import 'package:remax_mapstate/domain/entities/params/whatsapp_params.dart';
import 'package:remax_mapstate/domain/use_cases/get_developer_contact.dart';
import 'package:remax_mapstate/domain/use_cases/make_phone_call.dart';
import 'package:remax_mapstate/domain/use_cases/open_map.dart';
import 'package:remax_mapstate/domain/use_cases/open_whats_app.dart';

part 'developer_contact_state.dart';

class DeveloperContactCubit extends Cubit<DeveloperContactState> {
  final GetDeveloperContactCase getDeveloperContactCase;
  final OpenWhatsappCase openWhatsappCase;
  final OpenMapCase openMapCase;
  final MakePhoneCallCase makePhoneCallCase;

  DeveloperContactCubit({
    required this.openMapCase,
    required this.makePhoneCallCase,
    required this.openWhatsappCase,
    required this.getDeveloperContactCase,
  }) : super(LoadingDeveloperContactState());


  /// load the current developer data
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


  /// To open whats app
  void openWhatsApp({required String welcomeText, required String text}) {
    if (state.contactDeveloperEntity != null) {
      final whatsappNum = state.contactDeveloperEntity!.empPhoneNum;
      final empName = state.contactDeveloperEntity!.empFirstName;
      openWhatsappCase(WhatsappParams(
          num: whatsappNum,
          text:
              "$welcomeText $empName $text"));
    }
  }


  /// To open directions
  void openMap() {
    // if (state.contactDeveloperEntity != null) {
    //   if (state.contactDeveloperEntity!.mapEntity != null) {
    //     final mapEntity = state.contactDeveloperEntity!.mapEntity!;
    //     openMapCase(mapEntity);
    //   }
    // }
  }


  /// To make a phone call
  void makePhoneCall() {
    if (state.contactDeveloperEntity != null) {
      final phoneNum = state.contactDeveloperEntity!.empPhoneNum;
      makePhoneCallCase(
          PhoneNumParams(phoneNum: phoneNum));
    }
  }


  /// emit if not closed
  void _emitIfNotClosed(DeveloperContactState state) {
    if (!isClosed) {
      emit(state);
    }
  }


}
