import 'package:flutter/material.dart';
import 'package:openalbion_weaponry/constants/app_constants.dart';
import 'package:openalbion_weaponry/features/about/about_screen.dart';
import 'package:openalbion_weaponry/features/drawer_based/sections/drawer_body_section.dart';
import 'package:openalbion_weaponry/features/drawer_based/sections/drawer_header_section.dart';
import 'package:openalbion_weaponry/features/global/debug_floating_action_button.dart';
import 'package:openalbion_weaponry/features/home/home_screen.dart';
import 'package:openalbion_weaponry/features/setting/setting_screen.dart';
import 'package:openalbion_weaponry/providers/app_start_provider.dart';
import 'package:openalbion_weaponry/providers/home_provider.dart';
import 'package:openalbion_weaponry/providers/search_provider.dart';
import 'package:openalbion_weaponry/src/settings/settings_controller.dart';
import 'package:provider/provider.dart';

class DrawerBasedScreen extends StatefulWidget {
  static const routeName = 'drawer_based_screen';
  final SettingsController settingsController;

  const DrawerBasedScreen({super.key, required this.settingsController});

  @override
  State<DrawerBasedScreen> createState() => _DrawerBasedScreenState();
}

class _DrawerBasedScreenState extends State<DrawerBasedScreen> {
  @override
  void initState() {

    context.read<AppStartProvider>().initializeShaker(context);
    context.read<AppStartProvider>().checkVersion(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()..getSearchResult()),
      ],
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              DrawerHeaderSection(),
              DrawerBodyScreen(),
            ],
          ),
        ),
        body: Consumer<HomeProvider>(builder: (context, provider, child) {
          switch (provider.selectedCategoryType) {
            case AppConstants.CATEGORY_TYPE_SETTING:
              return SettingScreen(settingsController: widget.settingsController);

            case AppConstants.CATEGORY_TYPE_ABOUT:
              return AboutScreen();

            default:
              return HomeScreen();
          }
        }),
      ),
    );
  }
}

class FabSection extends StatelessWidget {
  const FabSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      switch (provider.selectedCategoryType) {
        case AppConstants.CATEGORY_TYPE_SETTING:
        case AppConstants.CATEGORY_TYPE_ABOUT:
          return SizedBox();

        default:
          return Consumer<AppStartProvider>(builder: (context, startProvider, child) {
            if (startProvider.bugCategoryList.isNotEmpty) {
              return DebugFloatingActionButton(
                onTap: () {
                  startProvider.reportToFirebase("click_debug_report");
                  // TODO: dialog replacement
                  // DialogUtils.showDebugReport(
                  //     context: context,
                  //     titleList: startProvider.bugCategoryList,
                  //     onDimissied: () {},
                  //     onSubmited: (report) {
                  //       startProvider.reportBug(report: report);
                  //     });
                },
              );
            } else {
              return SizedBox();
            }
          });
      }
    });
  }
}
