import 'package:flutter/material.dart';
import 'package:remax_mapstate/presentation/journeys/drawer/navigation_list_item.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

class NavigationExpandedListItem extends StatelessWidget {
  final String title;
  final List<String> children;
  final Function(int languageIndex) onPressed;

  const NavigationExpandedListItem(
      {Key? key, required this.title, required this.onPressed, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            color: Theme.of(context).primaryColor.withOpacity(0.7),
          )
        ],
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        children: [
              for(int i=0;i<children.length;i++)
            NavigationSubListItem(title: children[i].t(context), onPressed:()=> onPressed(i)),
        ],
      ),
    );
  }
}
