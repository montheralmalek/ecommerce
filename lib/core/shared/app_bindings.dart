import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => SellerHomeController(), fenix: true);
    // Get.lazyPut(() => ItemController(), fenix: true);
    // Get.lazyPut(() => UnitController(), fenix: true);
    // Get.lazyPut(() => CategoryController(Get.find<CategoryService>()),
    //     fenix: true);

    // Get.putAsync<CategoryService>(() async => await CategoryService().init());
  }
}
