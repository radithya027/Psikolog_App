import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../infrastructure/navigation/routes.dart';

class BiodataPageController extends GetxController {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final statusController = TextEditingController();
  final addressController = TextEditingController();
  final selectedGender = ''.obs;
  var isContactInfoExpanded = false.obs;
  var name = ''.obs;
  final _box = GetStorage();

  var isLoading = false.obs;

  // Validation Observables
  var isNameValid = true.obs;
  var isAgeValid = true.obs;
  var isEmailValid = true.obs;
  var isStatusValid = true.obs;
  var isAddressValid = true.obs;

  @override
  void onClose() {
    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    statusController.dispose();
    super.onClose();
  }

  void validateFields() {
    isNameValid.value = nameController.text.isNotEmpty;
    isAgeValid.value = ageController.text.isNotEmpty;
    isEmailValid.value = emailController.text.isNotEmpty;
    isStatusValid.value = statusController.text.isNotEmpty;
    isAddressValid.value = addressController.text.isNotEmpty;
  }

  Future<void> submitProfile() async {
    validateFields();

    // Check if all fields are valid
    if (!isNameValid.value ||
        !isAgeValid.value ||
        !isEmailValid.value ||
        !isStatusValid.value ||
        !isAddressValid.value) {
      Get.snackbar("Error", "Please complete all required fields.");
      return;
    }

    isLoading.value = true;
    final url =
        Uri.parse('https://bpkbautodigital.com/api/user/create-profile');
    final accessToken = _box.read('access_token');

    if (accessToken == null) {
      Get.snackbar("Error", "Access token is missing.");
      isLoading.value = false;
      return;
    }

    try {
      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $accessToken'
        ..headers['Accept'] = 'application/json'
        ..fields['name'] = nameController.text
        ..fields['address'] = addressController.text
        ..fields['ages'] = ageController.text
        ..fields['email'] = emailController.text
        ..fields['status'] = statusController.text
        ..fields['gender'] = selectedGender.value;

      var response = await request.send();

      if (response.statusCode == 201) {
        // Parse and handle success response
        final responseBody = await response.stream.bytesToString();
        final responseData = jsonDecode(responseBody);

        name.value = responseData['name'] ?? '';
        Get.snackbar("Success", "Profile saved successfully.");
        Get.offAllNamed(Routes.NAVBAR);
      } else if (response.statusCode == 400) {
        // Handle Bad Request
        final responseBody = await response.stream.bytesToString();
        final responseData = jsonDecode(responseBody);
        Get.snackbar("Error", responseData['message'] ?? "Invalid data.");
      } else {
        // Handle other errors
        Get.snackbar("Error", "Failed to save profile. Please try again.");
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred.");
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
