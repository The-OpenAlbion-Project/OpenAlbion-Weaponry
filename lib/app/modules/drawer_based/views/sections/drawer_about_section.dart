import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:openalbion_weaponry/app/modules/drawer_based/controllers/drawer_based_controller.dart';
import 'package:openalbion_weaponry/constants/app_constants.dart';
import 'package:openalbion_weaponry/constants/app_enums.dart';
import 'package:openalbion_weaponry/features/global/inter_text.dart';
import 'package:openalbion_weaponry/providers/home_provider.dart';
import 'package:openalbion_weaponry/theme/app_color.dart';
import 'package:openalbion_weaponry/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerAboutSection extends StatelessWidget {
  final DrawerBasedController controller;
  const DrawerAboutSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          ListTile(
            selected: controller.drawerContent == DrawerContent.about,
            title: InterText(AppLocalizations.of(context)!.about,
                style: TextStyle(
                    color: controller.drawerContent == DrawerContent.about
                        ? secondaryRed
                        : get80PercentColor(context))),
            onTap: () {
            
              // provider.selectCategoryType(AppConstants.CATEGORY_TYPE_SETTING);
              // Navigator.pop(context);
            },
          )
        ],
      );
    });
  }
}
