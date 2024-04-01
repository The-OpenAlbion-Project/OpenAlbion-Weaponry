import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:openalbion_weaponry/app/core/based/based_controller.dart';
import 'package:openalbion_weaponry/app/core/states/page_state.dart';
import 'package:openalbion_weaponry/constants/app_enums.dart';
import 'package:openalbion_weaponry/data/vos/app_error.dart';
import 'package:openalbion_weaponry/data/vos/category_vo.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DrawerBasedController extends BasedController {
  final _drawerContent = DrawerContent.home.obs;
  get drawerContent => _drawerContent;

  final _versionName = ''.obs;
  get versionName => _versionName;

  final _categoryList = <CategoryVO>[].obs;
  RxList<CategoryVO> get categoryList => _categoryList;

  final _selectedCategory = Rx<CategoryVO?>(null);
  get selectedCategory => _selectedCategory;

  final _selectedCategoryType = ''.obs;
  get selectedCategoryType => _selectedCategoryType;

  final _appError = Rx<AppError>;
  get appError => _appError;

  @override
  void onInit() {
    super.onInit();
    _getVersion();
    _getFCMToken();
    _getCategoryList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _versionName.value = packageInfo.version;
  }

  void _getFCMToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("fire token - $fcmToken");
  }

  // api calls
  void _getCategoryList() async {
    callDataService(
      repository.getCategoryList(),
      onSuccess: (categoryList) {
        _categoryList.value = categoryList;
        _setInitialCategory();
      },
      onError: (error) {},
    );
  }

  void _setInitialCategory() {
    if (_categoryList.isNotEmpty) {
      _selectedCategory.value = _categoryList.first;
      _selectedCategoryType.value = _selectedCategory.value!.name;
      updatePageState(PageState.SUCCESS);
      if (_selectedCategory.value!.subcategories.isNotEmpty) {
        // _selectedSubCategory.value = selectedCategory.subcategories.first;
        // _getItemList();
      } else {
        throw Exception("Empty SubCategory List");
      }
    } else {
      throw Exception("Empty Category List");
    }
  }

  @override
  void showLoading() {
    super.showLoading();
  }

  @override
  void hideLoading() {
    super.hideLoading();
  }
}
