import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:openalbion_weaponry/app/weaponry_app.dart';
import 'package:openalbion_weaponry/data/vos/search_result_vo.dart';
import 'package:openalbion_weaponry/firebase_options.dart';
import 'package:openalbion_weaponry/persistent/hive_constants.dart';
import 'package:openalbion_weaponry/app/services/firebase_notification_service.dart';
import 'app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(SettingsService());
  settingsController.loadSettings();
  Get.put(FirebaseNotificationService());
  _initializeOrientation();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _initializeHive();
  await _initializeEnv();
  await _initializeCloudMessagingService();

  // runApp(MyApp(settingsController: settingsController));
  runApp(WeaponryApp(settingsController: settingsController));
}

Future<void> _initializeEnv() async {
  await dotenv.load(fileName: ".env");
}

Future<void> _initializeHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SeachResultVOAdapter());

  await Hive.openBox<SearchResultVO>(HiveConstants.BOX_NAME_SEARCH_RESULT_VO);
}

void _initializeOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

Future<void> _initializeCloudMessagingService() async {
  await Get.find<FirebaseNotificationService>().init();
}
