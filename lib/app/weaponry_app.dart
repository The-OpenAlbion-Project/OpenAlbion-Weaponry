import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:openalbion_weaponry/app/routes/app_pages.dart';
import 'package:openalbion_weaponry/providers/app_start_provider.dart';
import 'package:openalbion_weaponry/routes.dart';
import 'package:openalbion_weaponry/src/settings/settings_controller.dart';
import 'package:openalbion_weaponry/theme/app_theme.dart';
import 'package:openalbion_weaponry/utils/dialog_utils.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';

class WeaponryApp extends StatelessWidget {
  const WeaponryApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    //   return AnimatedBuilder(
    //     animation: settingsController,
    //     builder: (BuildContext context, Widget? child) {
    //       return MultiProvider(
    //         providers: [
    //           ChangeNotifierProvider(create: (_) => AppStartProvider()),
    //         ],
    //         child: Consumer<AppStartProvider>(builder: (context, provider, child) {
    //           return MaterialApp(
    //             // Providing a restorationScopeId allows the Navigator built by the
    //             // MaterialApp to restore the navigation stack when a user leaves and
    //             // returns to the app after it has been killed while running in the
    //             // background.
    //             restorationScopeId: 'app',
    //             debugShowCheckedModeBanner: false,
    //             // Provide the generated AppLocalizations to the MaterialApp. This
    //             // allows descendant Widgets to display the correct translations
    //             // depending on the user's locale.
    //             localizationsDelegates: const [
    //               AppLocalizations.delegate,
    //               GlobalMaterialLocalizations.delegate,
    //               GlobalWidgetsLocalizations.delegate,
    //               GlobalCupertinoLocalizations.delegate,
    //             ],
    //             supportedLocales: const [
    //               Locale('en', ''), // English, no country code
    //             ],

    //             // Use AppLocalizations to configure the correct application title
    //             // depending on the user's locale.
    //             //
    //             // The appTitle is defined in .arb files found in the localization
    //             // directory.
    //             onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,

    //             // Define a light and dark color theme. Then, read the user's
    //             // preferred ThemeMode (light, dark, or system default) from the
    //             // SettingsController to display the correct theme.
    //             theme: lightThemeData(context),
    //             darkTheme: darkThemeData(context),
    //             themeMode: settingsController.themeMode,

    //             // Define a function to handle named routes in order to support
    //             // Flutter web url navigation and deep linking.
    //             onGenerateRoute: (routeSetting) {
    //               return Routes.generateRoutes(routeSetting, settingsController);
    //             },
    //           );
    //         }),
    //       );
    //     },
    //   );
    // }

    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          fallbackLocale: Locale('en', ''),
          onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
          theme: lightThemeData(context),
          darkTheme: darkThemeData(context),
          themeMode: settingsController.themeMode,
          getPages: AppPages.routes,
          initialRoute: AppPages.INITIAL,
        );
      },
    );
  }
}
