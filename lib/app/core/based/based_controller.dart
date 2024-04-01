import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:openalbion_weaponry/app/core/based/based_response.dart';
import 'package:openalbion_weaponry/app/core/states/page_state.dart';
import 'package:openalbion_weaponry/app/core/states/snack_bar_state.dart';
import 'package:openalbion_weaponry/data/vos/app_error.dart';
import 'package:openalbion_weaponry/network/firebase/firebase_analytics_repository.dart';
import 'package:openalbion_weaponry/network/firebase/firebase_analytics_repository_impl.dart';
import 'package:openalbion_weaponry/network/repository/network_repository_v2.dart';
import 'package:openalbion_weaponry/network/repository/network_repository_v2_impl.dart';
import 'package:openalbion_weaponry/persistent/shared_preference.dart';

class BasedController extends GetxController {
  final NetworkRepositoryV2 repository = NetworkRepositoryV2Impl();
  final FirebaseAnalyticsRepository _fireRepository = FirebaseAnalyticsRepositoryImpl();
  final SharedPreference _preference = SharedPreference();

  /* handle page state */
  final _pageState = PageState.DEFAULT.obs;
  PageState get pageController => _pageState.value;
  void updatePageState(PageState updatedState) {
    _pageState.value = updatedState;
  }

  void showLoading() => updatePageState(PageState.LOADING);
  void hideLoading() => updatePageState(PageState.DEFAULT);
  void resetPageState() => updatePageState(PageState.DEFAULT);

  /* handle snackbar & toast */
  snackBar(String? message, {snackBarState = SnackBarState.DEFAULT}) {
    return GetSnackBar(
      message: message,
      duration: const Duration(seconds: 1),
    ).show();
  }

  toast(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);
  }

  dynamic callDataService<T>(
    Future<BasedResponse<T>> future, {
    Function(AppError error)? onError,
    Function(T response)? onSuccess,
    Function? onStart,
    Function? onComplete,
    Function? onRetry,
    Function? onAuthExpired,
  }) async {
    // Exception? _exception;

    onStart == null ? showLoading() : onStart();

    if (await checkConnection()) {
      toast("No Internet Connection");
      return;
    }

    final BasedResponse<T> response = await future;

    onComplete == null ? hideLoading() : onComplete();

    switch (response) {
      case ResponseSuccess<T>():
        if (response.data != null && onSuccess != null) {
          onSuccess(response.data as T);
        }
        break;

      case ResponseAuthExpired<T>():
        if (onAuthExpired != null) {
          onAuthExpired();
        }
        break;
      case ResponseError<T>():
        if (onError != null) {
          onError(AppError(code: response.code ?? '-', message: response.message ?? 'Unknown Error In Api Response'));
        }
        break;
    }
  }

  Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return true;
    } else {
      return false;
    }
  }
}
