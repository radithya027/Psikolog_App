import 'package:get/get.dart';

import '../../../../presentation/add_address_page/controllers/add_address_page.controller.dart';

class AddAddressPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAddressPageController>(
      () => AddAddressPageController(),
    );
  }
}
