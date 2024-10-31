import 'package:get/get.dart';

import '../../../../presentation/otp_page/controllers/otp_page.controller.dart';

class OtpPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpPageController>(
      () => OtpPageController(),
    );
  }
}
