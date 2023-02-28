import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

import '../../logic/cubit/broker_changed/broker_changed_cubit.dart';
import 'broker_data_widget.dart';
import '../../widgets/contact_info_widget.dart';
import 'broker_reviews/list_of_broker_reviews.dart';

class BottomCardDataHolder extends StatelessWidget {
  const BottomCardDataHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: BlocBuilder<BrokerChangedCubit, BrokerChangedState>(
            builder: (context, state) {
              if (state is OnBrokerChangedState) {
                /// init current broker
                final currentBroker = state.brokerEntity;
                return Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// rating
                        BrokerDataWidget(
                          dataKey: TranslateConstants.rating.t(context),
                          value: currentBroker.brokerRating.toDouble(),
                          isRating: true,
                        ),

                        /// name
                        BrokerDataWidget(
                          dataKey: TranslateConstants.name.t(context),
                          value: currentBroker.firstName,
                        ),

                        /// experienceYears
                        BrokerDataWidget(
                          dataKey: TranslateConstants.experienceYears.t(context),
                          value: currentBroker.experienceYears.toString(),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        /// contact info
                        ContactInfoWidget(
                          phoneNum: currentBroker.phoneNumber,
                          whatsapp: currentBroker.phoneNumber,
                          onWhatsappPressed: () {
                            context.read<BrokerChangedCubit>().openWhatsApp(
                                  welcomeText: TranslateConstants
                                      .welcomeWhatsappText
                                      .t(context),
                                  text: TranslateConstants
                                      .defaultClientWhatsappText
                                      .t(context),
                                );
                          },
                          onCallPressed: () {
                            context.read<BrokerChangedCubit>().makePhoneCall();
                          },
                        ),

                        /// reviews
                        ListOfBrokerReviews(
                          reviews: currentBroker.reviews,
                        ),
                      ],
                    ),
                  ),
                );
              }

              /// nothing to show
              return const Center(child: SizedBox.shrink());
            },
          ),
        ),
      ),
    );
  }
}
