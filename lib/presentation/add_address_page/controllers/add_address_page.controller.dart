import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddAddressPageController extends GetxController {
  final _box = GetStorage();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();
  final noteController = TextEditingController();
  var errorMessage = ''.obs;
  var addressList = [].obs;
  var isLoading = false.obs;
  var selectedAddress = {}.obs;
  var addressData = {}.obs;

  @override
  void onClose() {
    nameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    postalCodeController.dispose();
    noteController.dispose();
    super.onClose();
  }

  Future<void> addAddress() async {
    isLoading.value = true;

    try {
      final accessToken = _box.read('access_token');
      var response = await http.post(
        Uri.parse('https://bpkbautodigital.com/api/alamat/add-alamat'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: {
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
          // Update the addressList immediately without refreshing
          addressList.insert(
              0, data['data']); // Insert at the beginning of the list
          Get.snackbar('Success', 'Address added successfully');

          // Clear the text fields after adding the address
          nameController.clear();
          phoneNumberController.clear();
          addressController.clear();
          postalCodeController.clear();
          noteController.clear();
        } else {
          Get.snackbar('Error', 'Failed to add address');
        }
      } else {
        Get.snackbar('Error', 'Server error');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to server');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAddressData() async {
    isLoading.value = true;
    try {
      final accessToken = _box.read('access_token');
      var response = await http.get(
        Uri.parse('https://bpkbautodigital.com/api/alamat/all-alamat'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          addressList.value = data['data'];
        } else {
          Get.snackbar('Error', 'Failed to fetch addresses');
        }
      } else {
        Get.snackbar('Error', 'Server error');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to server');
    } finally {
      isLoading.value = false;
    }
  }

 Future<void> fetchSelectedAddress(int addressId) async {
  isLoading.value = true;
  try {
    final accessToken = _box.read('access_token');
    var response = await http.post(
      Uri.parse('https://bpkbautodigital.com/api/alamat/select-alamat/$addressId'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: {
        '_method': 'put',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['status'] == 'success') {
        selectedAddress.value = data['data'];
        Get.back(result: selectedAddress.value);
      } else {
        errorMessage.value = 'Failed to load selected address';
        Get.snackbar('Error', errorMessage.value);
      }
    } else {
      errorMessage.value = 'Server error: ${response.statusCode}';
      Get.snackbar('Error', errorMessage.value);
    }
  } catch (e) {
    errorMessage.value = 'Failed to connect to server: $e';
    Get.snackbar('Error', errorMessage.value);
  } finally {
    isLoading.value = false;
  }
}


  @override
  void onInit() {
    fetchAddressData();
    super.onInit();
  }
}
