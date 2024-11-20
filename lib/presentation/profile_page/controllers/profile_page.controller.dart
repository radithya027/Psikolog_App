import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:psikolog_app/infrastructure/navigation/routes.dart';

class ProfilePageController extends GetxController {
  var name = ''.obs;
  var status = ''.obs;
  var phoneNumber = ''.obs;
  var age = ''.obs;
  var address = ''.obs;
  final _box = GetStorage();
  var email = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      final accessToken = _box.read('access_token');
      final response = await http.get(
        Uri.parse('https://bpkbautodigital.com/api/auth/user-detail'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        name.value = data['user']['name'] ?? '';
        status.value = data['user']['status'] ?? '';
        phoneNumber.value = data['user']['phone_number'] ?? '';
        age.value = data['user']['ages']?.toString() ?? '';
        email.value = data['user']['email'] ?? '';
      } else {
        print('Failed to load user profile');
      }
    } catch (e) {
      print('Error fetching profile: $e');
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      final accessToken = _box.read('access_token');

      final response = await http.post(
        Uri.parse('https://bpkbautodigital.com/api/auth/logout'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await _box.erase();
        name.value = '';
        status.value = '';
        phoneNumber.value = '';
        age.value = '';
        email.value = '';
        Get.offAllNamed(Routes.LOGIN_PAGE);
      } else {
        print(response.statusCode);
        Get.snackbar(
          'Error',
          'Failed to logout. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while logging out: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  String getInitials() {
    if (name.isEmpty) {
      return '';
    }

    List<String> nameParts = name.value.split(' ');
    String initials = '';

    if (nameParts.isNotEmpty) {
      initials += nameParts[0][0]; // First letter of the first name
    }

    if (nameParts.length > 1) {
      initials +=
          nameParts[1][0]; // First letter of the last name (if available)
    }

    return initials.toUpperCase(); // Ensure initials are in uppercase
  }
}
