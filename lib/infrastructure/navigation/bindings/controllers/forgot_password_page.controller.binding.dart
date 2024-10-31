import 'package:get/get.dart';

import '../../../../presentation/forgot_password_page/controllers/forgot_password_page.controller.dart';

class ForgotPasswordPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordPageController>(
      () => ForgotPasswordPageController(),
    );
  }
}
