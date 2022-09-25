import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/presentation/logic/cubit/choose_favorite_area/choose_favorite_area_cubit.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

import '../../common/constants/sizes.dart';



class MultiSelectionHelper {
  MultiSelectionHelper();

  /// show multiSelection filter
  void showMultiSelect({
    required BuildContext context,
    required List<AreaEntity> allAreas,
    required ChooseFavoriteAreaCubit chooseFavoriteAreaCubit,
  })  {
     showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(Sizes.dimen_10.w),
          topLeft: Radius.circular(Sizes.dimen_10.w),
        ),
      ),
      builder: (ctx) {
        return Container(
          color: AppColor.fadeBlack,
          child: MultiSelectBottomSheet(

            /// items to select from
            items: _getItems(allAreas),

            /// type of list item
            listType: MultiSelectListType.CHIP,

            /// To make selected items at the beginning
            separateSelectedItems: true,

            /// initial selected value
            initialValue: chooseFavoriteAreaCubit.state.selectedAreas,

            /// title
            title: Text(
              TranslateConstants.chooseFavoriteAreas.t(context),
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold,color: AppColor.geeBung),
            ),

            /// cancel & ok texts
            confirmText: Text(TranslateConstants.okay.t(context)),
            cancelText: Text(TranslateConstants.cancel.t(context)),

            /// icons
            closeSearchIcon: const Icon(Icons.clear,color: AppColor.geeBung,),
            searchIcon: const Icon(Icons.search_outlined,color: AppColor.geeBung,),

            /// search
            searchable: true,
            searchHint: TranslateConstants.searchForArea.t(context),
            searchHintStyle: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.bold,color: AppColor.geeBung),
            searchTextStyle: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.bold,color: AppColor.geeBung),

            /// onUnSelected
            unselectedColor: AppColor.extraFadeGeeBung,
            itemsTextStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.normal,color: AppColor.black),


            /// onSelected
            selectedColor: AppColor.geeBung,
            selectedItemsTextStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold,color: AppColor.black),

            onConfirm: (values) {
              final List<AreaEntity> selectedAreas = values.map((e) => e as AreaEntity ).toList();
              chooseFavoriteAreaCubit.changeSelected(selectedAreas);
              //_onPressed(filterOnScreensBloc,values[1],advancedSearchEnum);
            },
          ),
        );
      },
    );
  }

  /* void _onPressed( FilterOnScreensBloc filterOnScreensBloc,dynamic selectedItem,AdvancedSearchEnum advancedSearchEnum){
    if(advancedSearchEnum == AdvancedSearchEnum.network){
      filterOnScreensBloc.add(ChangeNetworkFilter(networkEntity: selectedItem as NetworkEntity));
    }

  }*/

  List<MultiSelectItem> _getItems(List<AreaEntity> areas) {
    return areas
        .map(
          (area) => MultiSelectItem<AreaEntity>(area, area.name),
        )
        .toList();
  }
}
