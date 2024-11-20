import 'package:get/get.dart';

import '../../../../presentation/edit_address_page/controllers/edit_address_page.controller.dart';

class EditAddressPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAddressPageController>(
      () => EditAddressPageController(),
    );
  }
}
