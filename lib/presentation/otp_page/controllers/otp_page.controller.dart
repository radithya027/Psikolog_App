import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../infrastructure/navigation/routes.dart';

class OtpPageController extends GetxController {
  final _box = GetStorage();
  late List<TextEditingController> otpControllers;
  var isLoading = false.obs; // Loading indicator

  @override
  void onInit() {
    super.onInit();
    
    otpControllers = List.generate(4, (index) => TextEditingController());
  }

 int getCombinedOtp() {
  final combinedOtp = otpControllers.map((controller) => controller.text).join();
  print("Combined OTP: $combinedOtp");  // Log the combined OTP
  return int.tryParse(combinedOtp) ?? 0;
}


  Future<void> submitOtp(int otp) async {
  if (otp == 0) {
    Get.snackbar("Error", "Please enter a valid OTP.");
    return;
  }

  isLoading.value = true;
  final url = 'https://bpkbautodigital.com/api/user/verify-otp';
  final accessToken = _box.read('access_token');

  if (accessToken == null) {
    Get.snackbar("Error", "Access token not found. Please log in again.");
    isLoading.value = false;
    return;
  }

  print("Submitting OTP: $otp with Access Token: $accessToken"); 

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({'otp': otp.toString()}),
  );

  if (response.statusCode == 200) {
    Get.snackbar("OTP Submitted", "OTP verified successfully");
    Get.toNamed(Routes.BIODATA_PAGE);
  } else {
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
    Get.snackbar("Invalid OTP", "The OTP you entered is incorrect.");
  }

  isLoading.value = false;
}



  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
