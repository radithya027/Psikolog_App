import 'package:get/get.dart';

import '../../../../presentation/realtime_page/controllers/realtime_page.controller.dart';

class RealtimePageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RealtimePageController>(
      () => RealtimePageController(),
    );
  }
}
