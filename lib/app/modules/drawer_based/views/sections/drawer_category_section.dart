import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openalbion_weaponry/app/core/states/page_state.dart';
import 'package:openalbion_weaponry/app/modules/drawer_based/controllers/drawer_based_controller.dart';
import 'package:openalbion_weaponry/constants/app_dimens.dart';
import 'package:openalbion_weaponry/data/vos/category_vo.dart';
import 'package:openalbion_weaponry/features/global/inter_text.dart';
import 'package:openalbion_weaponry/providers/home_provider.dart';
import 'package:openalbion_weaponry/providers/based_provider.dart';
import 'package:openalbion_weaponry/theme/app_color.dart';
import 'package:openalbion_weaponry/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DrawerCategorySection extends StatelessWidget {
  final DrawerBasedController controller;
  const DrawerCategorySection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    switch (controller.pageController) {
      case PageState.LOADING:
        return _buildLoadingUI(context);

      case PageState.SUCCESS:
        return _buildCompleteUI(context);

      default:
        return SizedBox();
    }
  }

  Widget _buildCompleteUI(BuildContext context) {
    return Obx(() {
      return Column(
        children: controller.categoryList.value.getUniqueTypeList().map((type) {
          return Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: Column(
              children: [
                ExpansionTile(
                  collapsedIconColor: get80PercentColor(context),
                  iconColor: secondaryRed,
                  initiallyExpanded: controller.selectedCategoryType.value == type,
                  title: InterText(convertTypeToLocalizedName(type, context)),
                  children: controller.categoryList.value.getByType(type).map((category) {
                    return ListTile(
                      selected: controller.selectedCategory.value.id == category.id,
                      title: InterText("  ${category.name}",
                          style: TextStyle(
                              color: controller.selectedCategory.value.id == category.id &&
                                      controller.selectedCategoryType.value == controller.selectedCategory.value.type
                                  ? secondaryRed
                                  : get80PercentColor(context))),
                      onTap: () {
                        // provider.setCategoryAndSubCategory(catId: category.id, setFirstSubcategory: true);
                        // Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
                Divider(color: get60PercentColor(context), endIndent: MARGIN_MEDIUM_2, height: 2),
              ],
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildLoadingUI(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: getCardColor(context),
      highlightColor: Colors.grey.withOpacity(0.4),
      child: Column(
        children: [
          ExpansionTile(
            initiallyExpanded: true,
            expandedAlignment: Alignment.centerLeft,
            title: Container(
              color: whiteText,
              width: 20,
              height: 10,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
                child: Container(
                  color: whiteText,
                  width: 80,
                  height: 10,
                ),
              ),
              SizedBox(height: MARGIN_LARGE),
              Padding(
                padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
                child: Container(
                  color: whiteText,
                  width: 80,
                  height: 10,
                ),
              ),
            ],
          ),
          SizedBox(height: MARGIN_LARGE),
          ExpansionTile(
            initiallyExpanded: true,
            expandedAlignment: Alignment.centerLeft,
            title: Container(
              color: whiteText,
              width: 20,
              height: 10,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
                child: Container(
                  color: whiteText,
                  width: 80,
                  height: 10,
                ),
              ),
              SizedBox(height: MARGIN_LARGE),
              Padding(
                padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
                child: Container(
                  color: whiteText,
                  width: 80,
                  height: 10,
                ),
              ),
            ],
          ),
          SizedBox(height: MARGIN_LARGE),
          ExpansionTile(
            initiallyExpanded: true,
            expandedAlignment: Alignment.centerLeft,
            title: Container(
              color: whiteText,
              width: 20,
              height: 10,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
                child: Container(
                  color: whiteText,
                  width: 80,
                  height: 10,
                ),
              ),
              SizedBox(height: MARGIN_LARGE),
              Padding(
                padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
                child: Container(
                  color: whiteText,
                  width: 80,
                  height: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
