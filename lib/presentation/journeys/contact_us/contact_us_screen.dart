import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/journeys/contact_us/social_media_links_widget.dart';
import 'package:remax_mapstate/presentation/logic/cubit/contact_us/contact_us_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/app_text_form_field.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';
import 'package:remax_mapstate/presentation/widgets/logo_with_slogan.dart';
import 'package:remax_mapstate/presentation/widgets/stack_with_full_background.dart';

import '../../../common/screen_utils/screen_util.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../widgets/btn_with_box_shadow.dart';
import '../../widgets/text_field_large_container.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  /// ContactUsCubit
  late final ContactUsCubit _contactUsCubit;

  /// controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();

  /// formKey
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _contactUsCubit = getItInstance<ContactUsCubit>();
  }

  @override
  void dispose() {
    _contactUsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _contactUsCubit,
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
                // TODO: implement listener
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
                          AppTextFormField(
                            label: TranslateConstants.title.t(context),
                          ),
                          TextFieldLargeContainer(
                            appTextField: AppTextFormField(
                              label: TranslateConstants.subject.t(context),
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
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: SocialMediaLinksWidget(),
                    ),
                  ],
                );
              },
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
    // userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // title
    final title = titleController.value.text;

    // subject
    final subject = subjectController.value.text;

    _contactUsCubit.sendContactUs(
      userToken: userToken,
      title: title,
      subject: subject,
    );
  }
}
