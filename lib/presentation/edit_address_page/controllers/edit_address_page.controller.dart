import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditAddressPageController extends GetxController {
  final _box = GetStorage();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();
  final noteController = TextEditingController();

  var isLoading = false.obs;
  var addressData = {}.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      addressData.value = Get.arguments;
      _populateFields();
    }
  }

  void _populateFields() {
    nameController.text = addressData['name'] ?? '';
    phoneNumberController.text = addressData['phone_number'] ?? '';
    addressController.text = addressData['address'] ?? '';
    postalCodeController.text = addressData['postal_code'] ?? '';
    noteController.text = addressData['note'] ?? '';
  }

  Future<void> updateAddress() async {
    isLoading.value = true;
    try {
      final accessToken = _box.read('access_token');
      final response = await http.post(
        Uri.parse(
            'https://bpkbautodigital.com/api/alamat/update-alamat/${addressData['id']}'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $accessToken',
        },
        body: {
          '_method': 'put',
          'name': nameController.text,
          'phone_number': phoneNumberController.text,
          'address': addressController.text,
          'postal_code': postalCodeController.text,
          'note': noteController.text,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          Get.snackbar('Success', 'Address updated successfully');
        } else {
          print(response.statusCode);
          Get.snackbar('Error', 'Failed to update address');
        }
      } else {
        print(response.statusCode);
        Get.snackbar('Error', 'Server error');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to server');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    postalCodeController.dispose();
    noteController.dispose();
    super.onClose();
  }
}
