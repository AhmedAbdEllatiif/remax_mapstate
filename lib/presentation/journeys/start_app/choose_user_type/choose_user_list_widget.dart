import 'package:flutter/material.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/choose_user_type/user_type_card.dart';

import '../../../../common/enums/user_types.dart';
import '../../../../domain/entities/current_user.dart';

class ChooseUserListWidget extends StatelessWidget {

   ChooseUserListWidget({Key? key}) : super(key: key);

  final double runSpacing = 30;
  final double spacing = 30;
  final int listSize = 3;
  final columns = 2;

  //final usersList = ['client', 'Ambassador', 'Broker'];
  final usersList = [UserType.client, UserType.broker, UserType.ambassador];

  @override
  Widget build(BuildContext context) {
    final w = (MediaQuery.of(context).size.width - runSpacing * (columns - 1)) /
        columns;
    return Center(
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: runSpacing,
          spacing: spacing,
          //alignment: WrapAlignment.center,
          alignment: WrapAlignment.spaceAround,
          children: List.generate(
            listSize,
                (index) {
              return SizedBox(
                //margin: EdgeInsets.symmetric(horizontal: 2),
                width: w - 20,
                height: w - 20,
                //color: Colors.green[200],
                child: UserTypeCard(
                  currentUserEntity: CurrentUserEntity(
                    currentUserStr: usersList[index].toShortString(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
