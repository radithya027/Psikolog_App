import 'package:get/get.dart';

import '../../../../presentation/resetpassword_page/controllers/resetpassword_page.controller.dart';

class ResetpasswordPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetpasswordPageController>(
      () => ResetpasswordPageController(),
    );
  }
}
