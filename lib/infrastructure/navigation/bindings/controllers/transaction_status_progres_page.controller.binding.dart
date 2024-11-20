import 'package:get/get.dart';

import '../../../../presentation/TransactionStatusProgres_page/controllers/transaction_status_progres_page.controller.dart';

class TransactionStatusProgresPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionStatusProgresPageController>(
      () => TransactionStatusProgresPageController(),
    );
  }
}
