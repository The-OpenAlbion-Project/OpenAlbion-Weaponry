import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/drawer_based/bindings/drawer_based_binding.dart';
import '../modules/drawer_based/views/drawer_based_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DRAWER_BASED;

  static final routes = [
    GetPage(
      name: _Paths.DRAWER_BASED,
      page: () => const DrawerBasedView(),
      binding: DrawerBasedBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
  ];
}
