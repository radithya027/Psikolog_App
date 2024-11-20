import 'package:get/get.dart';

import '../../../../presentation/order_paket_page/controllers/order_paket_page.controller.dart';

class OrderPaketPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderPaketPageController>(
      () => OrderPaketPageController(),
    );
  }
}
