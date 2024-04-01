import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:openalbion_weaponry/app/modules/drawer_based/controllers/drawer_based_controller.dart';
import 'package:openalbion_weaponry/constants/app_dimens.dart';
import 'package:openalbion_weaponry/features/global/inter_text.dart';
import 'package:openalbion_weaponry/providers/home_provider.dart';
import 'package:openalbion_weaponry/theme/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerHeaderSection extends StatelessWidget {
  final DrawerBasedController controller;
  const DrawerHeaderSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    DrawerBasedController testController = Get.find();

    return DrawerHeader(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: primaryRed,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/svgs/ic_logo_transparent.svg',
                  // filterQuality: FilterQuality.high,
                  width: 50,
                  height: 50,
                ),
                SizedBox(height: MARGIN_MEDIUM_2),
                InterText(
                  AppLocalizations.of(context)!.appName,
                  style: TextStyle(
                      fontSize: TEXT_REGULAR_2X, fontWeight: FontWeight.w500, color: whiteText),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Obx(() {
              return InterText(
                'Version ${controller.versionName}',
                style: TextStyle(fontSize: TEXT_SMALL, fontWeight: FontWeight.w500, color: whiteText),
              );
            }),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                await launchUrl(Uri.parse("https://github.com/OpenAlbion"),
                    mode: LaunchMode.externalApplication);
              },
              icon: SvgPicture.asset('assets/images/svgs/ic_github.svg', width: MARGIN_LARGE),
              splashRadius: MARGIN_LARGE,
              constraints: BoxConstraints(
                minWidth: MARGIN_LARGE,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
