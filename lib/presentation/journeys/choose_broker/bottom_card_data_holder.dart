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

class BottomCardDataHolder extends StatelessWidget {
  const BottomCardDataHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: AppColor.fadeBlack,
      // elevation: 20,
      // shape: RoundedRectangleBorder(
      //   side: const BorderSide(color: AppColor.absoluteTransparentGeeBung, width: 1),
      //   borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
      // ),
      elevation: 20,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
      ),
      child: BlocBuilder<BrokerChangedCubit, BrokerChangedState>(
        builder: (context, state) {
          if (state is OnBrokerChangedState) {
            /// init current broker
            final currentBroker = state.brokerEntity;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// rating
                BrokerDataWidget(
                  dataKey: "Rating",
                  value: currentBroker.brokerRating.toDouble(),
                  isRating: true,
                ),

                /// name
                BrokerDataWidget(
                  dataKey: "Name",
                  value: currentBroker.firstName,
                ),

                /// age
                BrokerDataWidget(
                  dataKey: "Age",
                  value: "currentBroker.age.toString()",
                ),

                /// deals
                BrokerDataWidget(
                  dataKey: "Done Deals",
                  value: currentBroker.brokerDoneDeals.toString(),
                ),

                const SizedBox(
                  height: 30,
                ),

                /// contact info
                ContactInfoWidget(
                  phoneNum: currentBroker.phoneNumber,
                  whatsapp: currentBroker.phoneNumber,
                  onWhatsappPressed: () {
                    context.read<BrokerChangedCubit>().openWhatsApp(
                        welcomeText:
                            TranslateConstants.welcomeWhatsappText.t(context),
                        text: TranslateConstants.defaultClientWhatsappText.t(context),);
                  },
                  onCallPressed: () {
                    context.read<BrokerChangedCubit>().makePhoneCall();
                  },
                ),
              ],
            );
          }

          /// nothing to show
          return const Center(child: SizedBox.shrink());
        },
      ),
    );
  }
}
