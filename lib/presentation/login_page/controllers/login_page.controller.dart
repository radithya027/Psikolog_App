import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../authservice/authservice.dart';

class LoginPageController extends GetxController {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  var loading = false.obs;
  final phoneController = TextEditingController();
  final _box = GetStorage();
  final _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    // Pindahkan inisialisasi Firebase ke dalam onReady
    ever(loading, (_) => update()); // Memastikan UI terupdate saat loading berubah
  }

  @override
  void onReady() {
    super.onReady();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    try {
      await firebaseMessaging.requestPermission();
      final token = await firebaseMessaging.getToken();
      if (token != null) {
        _box.write('notification_token', token);
        print("Firebase Notification Token: $token");
      }
    } catch (e) {
      print("Error initializing Firebase: $e");
    }
  }

  Future<void> login() async {
    if (loading.value) return; // Prevent multiple calls
    
    loading.value = true;
    try {
      final phoneNumber = phoneController.text;
      final notificationToken = _box.read('notification_token');
      
      if (phoneNumber.isEmpty) {
        Get.snackbar("Error", "Please enter phone number");
        return;
      }

      final response = await http.post(
        Uri.parse('https://bpkbautodigital.com/api/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone_number': phoneNumber,
          'notification_token': notificationToken,
        }),
      );

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final accessToken = responseBody['access_token'];

        _authService.saveToken(accessToken);
        await sendOtp(phoneNumber, accessToken);
        
        Get.offAllNamed(Routes.OTP_PAGE);
      } else {
        Get.snackbar("Error", "Login failed. Please try again.");
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "An error occurred. Please try again.");
    } finally {
      loading.value = false;
    }
  }

  Future<void> sendOtp(String phoneNumber, String accessToken) async {
    try {
      final response = await http.post(
        Uri.parse('https://bpkbautodigital.com/api/user/send-otp'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'phone_number': phoneNumber}),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final otp = responseBody['otp'];
        _box.write('otp', otp);
        print('OTP received: $otp');
      } else {
        print("Failed to send OTP: ${response.statusCode}");
      }
    } catch (e) {
      print("Error sending OTP: $e");
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
