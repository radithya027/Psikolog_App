import 'package:get/get.dart';

import '../../../../presentation/lainnya_page/controllers/lainnya_page.controller.dart';

class LainnyaPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LainnyaPageController>(
      () => LainnyaPageController(),
    );
  }
}
