import 'package:flutter/material.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/choose_user_type/user_type_card.dart';

import '../../../../common/enums/user_types.dart';
import '../../../../domain/entities/user_entity.dart';

class ChooseUserListWidget extends StatelessWidget {
  ChooseUserListWidget({Key? key}) : super(key: key);

  final double runSpacing = 15;
  final double spacing = 15;
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
        child: Column(
          children: List.generate(
            listSize,
            (index) {
              return SizedBox(
                //margin: EdgeInsets.symmetric(horizontal: 2),
                width: w,
                // height: w - 50,
                //color: Colors.green[200],
                child: UserTypeCard(
                  currentUserEntity: UserEntity(
                    userType: usersList[index],
                    firstName: "",
                    lastName: "",
                    email: "",
                    id: -1,
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
