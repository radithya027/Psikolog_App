import 'package:get/get.dart';

import '../../../../presentation/paymentbook_page/controllers/paymentbook_page.controller.dart';

class PaymentbookPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentbookPageController>(
      () => PaymentbookPageController(),
    );
  }
}
