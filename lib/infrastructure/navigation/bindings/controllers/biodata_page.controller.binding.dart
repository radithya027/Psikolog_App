import 'package:get/get.dart';

import '../../../../presentation/biodata_page/controllers/biodata_page.controller.dart';

class BiodataPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BiodataPageController>(
      () => BiodataPageController(),
    );
  }
}
