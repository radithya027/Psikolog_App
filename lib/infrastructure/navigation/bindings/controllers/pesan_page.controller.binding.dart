import 'package:get/get.dart';

import '../../../../presentation/pesan_page/controllers/pesan_page.controller.dart';

class PesanPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PesanPageController>(
      () => PesanPageController(),
    );
  }
}
