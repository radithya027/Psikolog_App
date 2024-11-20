import 'package:get/get.dart';

import '../../../../presentation/dokterharian_page/controllers/dokterharian_page.controller.dart';

class DokterharianPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DokterharianPageController>(
      () => DokterharianPageController(),
    );
  }
}
