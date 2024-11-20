import 'package:get/get.dart';

import '../../../../presentation/listdoctor_page/controllers/listdoctor_page.controller.dart';

class ListdoctorPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListdoctorPageController>(
      () => ListdoctorPageController(),
    );
  }
}
