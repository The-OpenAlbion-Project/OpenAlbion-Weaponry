import 'package:flutter/material.dart';
import 'package:openalbion_weaponry/app/modules/drawer_based/controllers/drawer_based_controller.dart';
import 'package:openalbion_weaponry/app/modules/drawer_based/views/sections/drawer_about_section.dart';
import 'package:openalbion_weaponry/app/modules/drawer_based/views/sections/drawer_category_section.dart';
import 'package:openalbion_weaponry/app/modules/drawer_based/views/sections/drawer_setting_section.dart';
import 'package:openalbion_weaponry/constants/app_dimens.dart';
import 'package:openalbion_weaponry/theme/app_theme.dart';

class DrawerBodyScreen extends StatelessWidget {
  final DrawerBasedController controller;
  const DrawerBodyScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        children: [
          DrawerCategorySection(controller: controller),
          DrawerAboutSection(controller: controller),
          Divider(color: get60PercentColor(context), endIndent: MARGIN_MEDIUM_2, height: 2),
          DrawerSettingSection(controller: controller),
        ],
      ),
    ));
  }
}
