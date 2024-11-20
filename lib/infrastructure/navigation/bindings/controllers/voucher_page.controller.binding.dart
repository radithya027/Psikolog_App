import 'package:get/get.dart';

import '../../../../presentation/voucher_page/controllers/voucher_page.controller.dart';

class VoucherPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoucherPageController>(
      () => VoucherPageController(),
    );
  }
}
