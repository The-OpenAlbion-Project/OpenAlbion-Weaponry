// ignore_for_file: use_build_context_synchronously

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:openalbion_weaponry/data/vos/app_error.dart';
import 'package:openalbion_weaponry/data/vos/report_vo.dart';
import 'package:openalbion_weaponry/data/vos/version_result_vo.dart';
import 'package:openalbion_weaponry/network/firebase/firebase_analytics_repository.dart';
import 'package:openalbion_weaponry/network/firebase/firebase_analytics_repository_impl.dart';
import 'package:openalbion_weaponry/network/repository/network_repository.dart';
import 'package:openalbion_weaponry/network/repository/network_repository_impl.dart';
import 'package:openalbion_weaponry/persistent/shared_preference.dart';
import 'package:openalbion_weaponry/providers/based_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shake/shake.dart';

class AppStartProvider extends BasedProvider {
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
  void initializeShaker(BuildContext context) {
    _bugCategoryList = ["Item Missing", "Item Wrong Info", "Other"];
    _detector = ShakeDetector.autoStart(
        minimumShakeCount: 2,
        onPhoneShake: () async {
          var shakeEnabled = await _preference.getShakeToReport();
          if (shakeEnabled && !isShaking) {
            isShaking = true;
            // TODO: dialog replacement

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
    if (await handleConnectionView(isReplaceView: false)) {
      return;
    }
    Either<AppError, String> data = await _repository.reportBug(report: report);
    data.fold((L) {
      appError = L;
    }, (R) {
      setNotifyMessage("Thanks For Your Report.");
    });
  }

  // check version
  void checkVersion(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 1000));
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    int currentVersionExtanded = getExtendedVersionNumber(currentVersion);

    if (await handleConnectionView(isReplaceView: true)) {
      return;
    }
    Either<AppError, VersionResultVO> data = await _repository.checkVersion();
    data.fold((L) {
      appError = L;
    }, (R) {
      String latestVersion = R.version;
      int latestVersionExtended = getExtendedVersionNumber(latestVersion);
      if (currentVersionExtanded < latestVersionExtended) {
        // TODO: dialog replacement
        // DialogUtils.showVersionUpdateDialog(
        //     context: context,
        //     versionResult: R,
        //     onUpdate: () async {
        //       await launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.openalbion.weaponry"),
        //           mode: LaunchMode.externalApplication);
        //     });
      }
    });
  }

  int getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }

  @override
  void dispose() {
    _detector.stopListening();
    super.dispose();
  }
}
