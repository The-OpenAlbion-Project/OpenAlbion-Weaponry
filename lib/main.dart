import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:openalbion_weaponry/data/vos/search_result_vo.dart';
import 'package:openalbion_weaponry/firebase_options.dart';
import 'package:openalbion_weaponry/network/repository/network_repository_impl.dart';
import 'package:openalbion_weaponry/persistent/dao/search_result_dao.dart';
import 'package:openalbion_weaponry/persistent/hive_constants.dart';

import 'app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(SettingsService());
  settingsController.loadSettings();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _initializeHive();
  await _initializeEnv();
  // await NetworkRepositoryImpl().getCraftingDetail(itemId: 18);

  _handleFirebaseCloudMessaging();
  _initializeOrientation();

  runApp(MyApp(settingsController: settingsController));
}

void _handleFirebaseCloudMessaging() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    // _showLocalNotification(message.data['title'], message.data['message']);
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
}

// void _showLocalNotification(String title, String message) async {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   // request permission
//   flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//       ?.requestNotificationsPermission();
// // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('app_icon');

//   const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
//     '100',
//     'open_albion_channel',
//     channelDescription: 'Notification channel for OpenAlbion Weaponry application',
//     importance: Importance.max,
//     priority: Priority.high,
//     ticker: 'ticker',
//     icon: "app_icon",
//   );
//   const NotificationDetails notificationDetails =
//       NotificationDetails(android: androidNotificationDetails);
//   await flutterLocalNotificationsPlugin.show(10, title, message, notificationDetails, payload: 'item x');
// }

Future<void> _initializeEnv() async {
  await dotenv.load(fileName: ".env");
}

_initializeHive() async {
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
