import 'package:get/get.dart';

import '../../../../presentation/dokterrealtime_page/controllers/dokterrealtime_page.controller.dart';

class DokterrealtimePageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DokterrealtimePageController>(
      () => DokterrealtimePageController(),
    );
  }
}
