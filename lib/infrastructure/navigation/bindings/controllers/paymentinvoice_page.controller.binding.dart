import 'package:get/get.dart';

import '../../../../presentation/paymentinvoice_page/controllers/paymentinvoice_page.controller.dart';

class PaymentinvoicePageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentinvoicePageController>(
      () => PaymentinvoicePageController(),
    );
  }
}
