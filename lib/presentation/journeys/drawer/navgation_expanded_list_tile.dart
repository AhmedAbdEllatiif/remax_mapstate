import 'package:flutter/material.dart';
import 'package:remax_mapstate/presentation/journeys/drawer/navigation_list_item.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

import '../../themes/theme_color.dart';

class NavigationExpandedListItem extends StatefulWidget {
  final String title;
  final List<String> children;
  final Function(int languageIndex) onPressed;

  const NavigationExpandedListItem(
      {Key? key, required this.title, required this.onPressed, required this.children})
      : super(key: key);

  @override
  State<NavigationExpandedListItem> createState() => _NavigationExpandedListItemState();
}

class _NavigationExpandedListItemState extends State<NavigationExpandedListItem> {

  Color expansionChangesColor = AppColor.white;


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
        leading: Icon(Icons.language_outlined,color: expansionChangesColor,),
        childrenPadding: EdgeInsets.zero,
        iconColor: AppColor.vulcan,
        collapsedIconColor: AppColor.white,
        collapsedBackgroundColor: AppColor.vulcan,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: expansionChangesColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        onExpansionChanged: (isExpanded){

          setState(() {
            expansionChangesColor = isExpanded? AppColor.vulcan: AppColor.white;
          });
        },
        children: [
              for(int i=0;i<widget.children.length;i++)
            NavigationSubListItem(title: widget.children[i].t(context), onPressed:()=> widget.onPressed(i)),
        ],
      ),
    );
  }
}
