import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/domain/entities/params/login_params.dart';
import 'package:remax_mapstate/presentation/bloc/login/login_bloc.dart';
import 'package:remax_mapstate/presentation/cubit/change_login_view/change_login_view_cubit.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/login/phone_num_animation.dart';
import 'package:remax_mapstate/presentation/widgets/btn_with_box_shadow.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

import '../../../../common/constants/assets_constants.dart';
import '../../../../common/constants/sizes.dart';

class PhoneNumWidget extends StatefulWidget {


  const PhoneNumWidget({Key? key}) : super(key: key);

  @override
  State<PhoneNumWidget> createState() => _PhoneNumWidgetState();
}

class _PhoneNumWidgetState extends State<PhoneNumWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'EG';
  PhoneNumber number =
      PhoneNumber(phoneNumber: "", isoCode: 'EG');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(Sizes.dimen_16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /// Phone Number Verification
               /*Padding(
                padding: EdgeInsets.symmetric(vertical:Sizes.dimen_22.h),
                child: Text(
                  TranslateConstants.enterPhoneNum.t(context),
                  style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),*/

              /// Lottie animation
              SizedBox(
                width: ScreenUtil.screenWidth,
                height: ScreenUtil.screenHeight * 0.32,
                child: const PhoneNumAnimation(),
              ),



              Container(
                padding: const EdgeInsets.all(20.0),
                margin: EdgeInsets.only(top: 50),

                child: InternationalPhoneNumberInput(
                  searchTextStyle: const TextStyle(color: AppColor.black),
                  countryNameTextStyle: const TextStyle(color: AppColor.black),
                  dialCodeTextStyle: const TextStyle(color: AppColor.black),
                  textStyle: const TextStyle(color: AppColor.geeBung),
                  selectorTextStyle: const TextStyle(color: AppColor.geeBung),

                  /// bottomSheet
                  selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.DIALOG,
                      countryComparator: (c, b) => -1,
                      setSelectorButtonAsPrefixIcon: false,
                      trailingSpace: true,
                      useEmoji: true,
                      showFlags: true),

                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.disabled,
                  // text with flag
                  initialValue: number,
                  textFieldController: controller,
                  formatInput: true,
                  autoFocus: true,
                  cursorColor: AppColor.geeBung,


                  /// the box of phone num
                  inputDecoration:  InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
                        borderSide:
                            BorderSide(color: AppColor.geeBung, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
                        borderSide: BorderSide(color: AppColor.absoluteTransparentGeeBung, width: 0.7),
                      )),

                  /// box inside bottomSheet or dialog
                  searchBoxDecoration: InputDecoration(
                      labelText: TranslateConstants.searchCountryLabel.t(context),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.black, width: 1.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      )),

                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),

                  /// onChange
                  onInputChanged: (PhoneNumber number) {
                    print(" onInputChanged >> ${number.phoneNumber}");
                  },

                  /// onInputValidated
                  onInputValidated: (bool value) {
                    print("onInputValidated >> $value");
                  },

                  /// On Saved
                  onSaved: (PhoneNumber number) {
                    final currentNum = number.phoneNumber;
                    if (currentNum != null) {
                      context.read<LoginBloc>().add(RequestPinCodeEvent(
                          loginParams: LoginParams(phoneNum: currentNum)));


                      ///Change the loginView
                      context.read<ChangeLoginViewCubit>().changeToPinCodeView();
                    }
                    print('On Saved: $number');
                  },
                ),
              ),
               SizedBox(height: Sizes.dimen_8.h),
              /// validate btn
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
                child: ButtonWithBoxShadow(
                text: TranslateConstants.sendPinCode.t(context)
                ,onPressed: (){
                  print("Validate ${formKey.currentState!.validate()}");
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                  }
                  formKey.currentState!.validate();
                }),
              ),

              /// update btn
              /*ElevatedButton(
                child: const Text('Update'),
                onPressed: () {
                  getPhoneNumber('+15417543010');
                },
              ),*/

              /// save btn
              /*ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  formKey.currentState!.save();
                },
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber("1124466700", 'EG');
    print("getPhoneNumber $number");

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
