import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/functions/contact_us_numbers.dart';
import 'package:remax_mapstate/common/functions/hide_keyboard.dart';
import 'package:remax_mapstate/data/params/open_facebook_params.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/journeys/contact_us/social_media_links_widget.dart';
import 'package:remax_mapstate/presentation/logic/bloc/launch_apps/launch_apps_bloc.dart';
import 'package:remax_mapstate/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:remax_mapstate/presentation/logic/cubit/contact_us/contact_us_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/app_text_form_field.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';
import 'package:remax_mapstate/presentation/widgets/logo_with_slogan.dart';
import 'package:remax_mapstate/presentation/widgets/stack_with_full_background.dart';

import '../../../common/functions/show_dialog.dart';
import '../../../data/params/whatsapp_params.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../widgets/btn_with_box_shadow.dart';
import '../../widgets/text_field_large_container.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  /// LaunchAppsBloc
  late final LaunchAppsBloc _launchAppsBloc;

  /// ContactUsCubit
  late final ContactUsCubit _contactUsCubit;

  /// controllers
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  /// formKey
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _contactUsCubit = getItInstance<ContactUsCubit>();
    _launchAppsBloc = getItInstance<LaunchAppsBloc>();
  }

  @override
  void dispose() {
    _contactUsCubit.close();
    _launchAppsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _contactUsCubit),
        BlocProvider(create: (context) => _launchAppsBloc),
      ],
      child: BlocListener<LaunchAppsBloc, LaunchAppsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: StackScaffoldWithFullBackground(
          /// appBar
          // appBar: AppBar(
          //   title: Text(
          //     TranslateConstants.contactUs.t(context),
          //   ),
          // ),

          appBarTitle: Text(
            TranslateConstants.contactUs.t(context),
          ),
          body: Padding(
            padding: EdgeInsets.only(
              bottom: Sizes.dimen_30,
              right: Sizes.dimen_16.w,
              left: Sizes.dimen_16.w,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocConsumer<ContactUsCubit, ContactUsState>(
                listener: (context, state) {
                  if (state is ContactUsSentSuccessfully) {
                    _clearFields();
                    _showSuccessDialog();
                  }

                  if (state is ErrorWhileSendingContactUs) {
                    _showFailedDialog();
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      const LogoWithSlogan(
                        margin: EdgeInsets.only(
                          bottom: 20,
                          top: 20,
                        ),
                      ),

                      /// form
                      Form(
                        key: _formKey,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          //spacing: 20, // to apply margin in the main axis of the wrap
                          runSpacing: Sizes.dimen_4.h,
                          children: [
                            //==> subject
                            AppTextFormField(
                              controller: subjectController,
                              label: TranslateConstants.subject.t(context),
                            ),

                            //==> body
                            TextFieldLargeContainer(
                              appTextField: AppTextFormField(
                                controller: bodyController,
                                label: TranslateConstants.body.t(context),
                                maxLines: 20,
                                contentPadding: const EdgeInsets.only(
                                  bottom: 100,
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                validateOnSubmit: true,
                                withFocusedBorder: false,
                                textInputType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// button send
                      state is LoadingToSendContactUs
                          ? const LoadingWidget()
                          : ButtonWithBoxShadow(
                              text: TranslateConstants.send.t(context),
                              onPressed: () {
                                if (_validate()) {
                                  _sendContactUs();
                                }
                              },
                            ),

                      const SizedBox(height: 50),

                      /// social media links
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SocialMediaLinksWidget(
                          launchAppsBloc: _launchAppsBloc,
                          onFacebookPressed: () => _openFacebook(),
                          onWhatsappPressed: () => _openWhatsapp(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// validate
  bool _validate() {
    //==> validate on form and received images list
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }
    return false;
  }

  /// to send a request with contactUs
  void _sendContactUs() {
    // to hide the keyboard
    hideKeyboard();

    // userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // userId
    final userId =
        context.read<AuthorizedUserCubit>().state.authorizedUserEntity.id;

    // subject
    final subject = subjectController.value.text;

    // body
    final body = bodyController.value.text;

    // send the request
    _contactUsCubit.sendContactUs(
      userId: int.tryParse(userId) ?? -1,
      userToken: userToken,
      subject: subject,
      body: body,
    );
  }

  void _clearFields(){
    subjectController.clear();
    bodyController.clear();
  }

  void _showSuccessDialog() {
    showAppDialog(
      context,
      buttonText: TranslateConstants.okay.t(context),
      message: TranslateConstants.requestSentSuccessfully.t(context),
    );
  }

  void _showFailedDialog() {
    showAppDialog(
      context,
      buttonText: TranslateConstants.okay.t(context),
      message: TranslateConstants.somethingWentWrong.t(context),
    );
  }

  /// to open whatsapp
  void _openWhatsapp() {
    final whatsappParams = WhatsappParams(
      num: getContactNumber(context: context),
      text: TranslateConstants.welcomeWhatsappText.t(context),
    );

    _launchAppsBloc.add(OpenWhatsAppEvent(whatsappParams: whatsappParams));
  }

  /// to open facebook
  void _openFacebook() {
    final openFacebookParams = OpenFaceBookParams(
      url: "https://www.facebook.com/mapestate.investment",
    );

    _launchAppsBloc
        .add(OpenFacebookEvent(openFaceBookParams: openFacebookParams));
  }
}
