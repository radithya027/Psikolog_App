import 'package:get/get.dart';

import '../../home_page/controllers/home_page.controller.dart';

class DokterrealtimePageController extends GetxController {
  final realtimeDoctorList = [].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Get the data passed from HomePageController
    realtimeDoctorList.value = Get.find<HomePageController>().realtimeDoctorList;
    isLoading.value = false;
  }
}
