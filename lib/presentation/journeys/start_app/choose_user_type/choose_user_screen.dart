import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/domain/entities/current_user.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/choose_user_type/user_type_card.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import '../../../../router/app_router.dart';

class ChooseUserScreen extends StatelessWidget {
  const ChooseUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            /// background fullImage
            /* Expanded(
              child: Opacity(
                opacity: 0.4,
                child: Image.asset(
                  AssetsImages.city,
                  fit: BoxFit.cover,
                ),
              ),
            ),*/
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Select User Type",
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 20,
                ),
                AlignedGrid(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AlignedGrid extends StatelessWidget {
  AlignedGrid({Key? key}) : super(key: key);

  final double runSpacing = 10;
  final double spacing = 10;
  final int listSize = 3;
  final columns = 2;

  //final usersList = ['client', 'Ambassador', 'Broker'];
  final usersList = [UserType.client, UserType.broker, UserType.other];

  void _navigateToNextScreen(context) {
    Navigator.of(context).pushNamed(AppRouter.mainScreen);
  }

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
          children: List.generate(listSize, (index) {
            return SizedBox(
              //margin: EdgeInsets.symmetric(horizontal: 2),
              width: w - 10,
              height: w - 10,
              //color: Colors.green[200],
              child: UserTypeCard(
                currentUserEntity: CurrentUserEntity(
                  currentUserStr: usersList[index].toShortString(),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

/* child: GridView.count(

          crossAxisCount: 3,
         // childAspectRatio: .5,
          //shrinkWrap: true,
          children: [
            Container(
              height: double.infinity,
              child: Card(
                child: Center(child: Text('User')),
                elevation: 5,
              ),
            ),
            Container(
              height: double.infinity,
              child: Card(
                child: Center(child: Text('User')),
                elevation: 5,
              ),
            ),

            Container(
              height: double.infinity,
              child: Card(
                child: Center(child: Text('User')),
                elevation: 5,
              ),
            ),
          ],
        ),*/

/*Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Center(
              child: Text("Select User",style: TextStyles.mainPageTitle,),
            ),

            GridView.count(crossAxisCount: 2,
            childAspectRatio: .5,
            children: [
              Container(
                height: double.infinity,
                child: Card(
                  child: Center(child: Text('User')),
                  elevation: 5,
                ),


              ),
              Container(
                height: double.infinity,
                child: Card(
                  child: Center(child: Text('User')),
                  elevation: 5,
                ),


              )
            ],
            )

            /*Container(
              height: 150,
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      child: Card(
                        child: Center(child: Text('User')),
                        elevation: 5,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      child: Card(

                        child: Center(child: Text('Ambassador')),
                        elevation: 5,
                      ),
                    ),
                  )
                ],
              ),
            )*/
          ],
        )*/
