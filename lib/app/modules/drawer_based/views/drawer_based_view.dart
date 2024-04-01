import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:openalbion_weaponry/app/modules/drawer_based/views/sections/drawer_body_section.dart';
import 'package:openalbion_weaponry/app/modules/drawer_based/views/sections/drawer_header_section.dart';

import '../controllers/drawer_based_controller.dart';

class DrawerBasedView extends GetView<DrawerBasedController> {
  const DrawerBasedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            DrawerHeaderSection(controller: controller),
            DrawerBodyScreen(controller: controller),
          ],
        ),
      ),
      // body: Consumer<HomeProvider>(builder: (context, provider, child) {
      //   switch (provider.selectedCategoryType) {
      //     case AppConstants.CATEGORY_TYPE_SETTING:
      //       return SettingScreen(settingsController: widget.settingsController);

      //     case AppConstants.CATEGORY_TYPE_ABOUT:
      //       return AboutScreen();

      //     default:
      //       return HomeScreen();
      //   }
      // }),
      body: SizedBox(),
    );
  }
}
