import 'package:get/get.dart';

class ForgotPasswordPageController extends GetxController {

   var currentStep = 0.obs;


  void nextStep() {
    if (currentStep < 2) {
      currentStep.value++;
    }
  }
  void previousStep() {
    if (currentStep > 0) {
      currentStep.value--;
    }
  }


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
