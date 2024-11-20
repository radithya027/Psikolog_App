import 'package:get/get.dart';

import '../../../../presentation/specificdoctor_page/controllers/specificdoctor_page.controller.dart';

class SpecificdoctorPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpecificdoctorPageController>(
      () => SpecificdoctorPageController(),
    );
  }
}
