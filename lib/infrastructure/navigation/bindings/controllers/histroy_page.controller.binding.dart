import 'package:get/get.dart';

import '../../../../presentation/histroy_page/controllers/histroy_page.controller.dart';

class HistroyPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistroyPageController>(
      () => HistroyPageController(),
    );
  }
}
