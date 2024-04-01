import 'package:get/get.dart';
import 'package:openalbion_weaponry/app/core/based/based_controller.dart';
import 'package:openalbion_weaponry/data/vos/app_error.dart';
import 'package:openalbion_weaponry/data/vos/report_vo.dart';
import 'package:openalbion_weaponry/network/firebase/firebase_analytics_repository.dart';
import 'package:openalbion_weaponry/network/firebase/firebase_analytics_repository_impl.dart';
import 'package:openalbion_weaponry/network/repository/network_repository.dart';
import 'package:openalbion_weaponry/network/repository/network_repository_impl.dart';
import 'package:openalbion_weaponry/persistent/shared_preference.dart';
import 'package:shake/shake.dart';

class AppStartService extends BasedController {
  AppError? appError;
  final NetworkRepository _repository = NetworkRepositoryImpl();
  final FirebaseAnalyticsRepository _fireRepository = FirebaseAnalyticsRepositoryImpl();
  final SharedPreference _preference = SharedPreference();

  // bug title list
  List<String> _bugCategoryList = [];
  List<String> get bugCategoryList => _bugCategoryList;
  bool isShaking = false;

  late ShakeDetector _detector;

  // bug report
  void initializeShaker() {
    _bugCategoryList = ["Item Missing", "Item Wrong Info", "Other"];
    _detector = ShakeDetector.autoStart(
        minimumShakeCount: 2,
        onPhoneShake: () async {
          var shakeEnabled = await _preference.getShakeToReport();
          if (shakeEnabled && !isShaking) {
            isShaking = true;
            // impact d7
            // DialogUtils.showDebugReport(
            //     context: context,
            //     titleList: _bugCategoryList,
            //     onDimissied: () {
            //       isShaking = false;
            //     },
            //     onSubmited: (report) {
            //       reportBug(report: report);
            //     });
          }
        });
  }

  void reportToFirebase(String message) {
    _fireRepository.reportToFirebase(message);
  }

  void reportBug({required ReportVO report}) async {
    callDataService(
      repository.reportBug(report: report),
      onSuccess: (response) {
        toast("Thanks For Your Report.");
      },
      onError: (error) {
        
      },
    );
  }
}
