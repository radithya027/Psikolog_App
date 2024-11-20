import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:psikolog_app/infrastructure/navigation/routes.dart';

import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class PaymentbookPageController extends GetxController {
  var bookDetail = <String, dynamic>{}.obs;
  final _box = GetStorage();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var orderId = ''.obs;
  var selectedAddress = {}.obs;
  var selectedVoucher = {}.obs;
  var discountAmount = 0.0.obs;
  var finalPrice = 0.0.obs;
  var totalAmount = 0.0.obs;
  final phoneController = TextEditingController();
  final alamatController = TextEditingController();

  void fetchBookDetail(String bookId) async {
    try {
      isLoading.value = true;

      final url = 'https://bpkbautodigital.com/api/book/show/$bookId';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          bookDetail.value = data['data'];
          totalAmount.value = (bookDetail['price'] ?? 0.0).toDouble();
          errorMessage.value = '';
        } else {
          errorMessage.value =
              'Failed to load book details: ${data['message']}';
        }
      } else {
        errorMessage.value = 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  var isOrderCompleted = false.obs;

  Future<void> makeOrder() async {
    isLoading.value = true;
    isOrderCompleted.value = false;

    try {
      var orderResponse = await _createOrder(
        address: alamatController.text,
        phone: phoneController.text,
      );
      if (orderResponse != null && orderResponse['status'] == 'success') {
        orderId.value = orderResponse['order_id'].toString();
        _box.write('order_id', orderId.value);

        var snapViewUrl = orderResponse['snap_view_url'];
        if (snapViewUrl != null) {
          isOrderCompleted.value = true;
          _proceedToPayment(snapViewUrl);
        } else {
          errorMessage.value = 'Failed to get Snap View URL';
        }
      } else {
        errorMessage.value = 'Failed to create order';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>?> _createOrder({
    required String address,
    required String phone,
  }) async {
    try {
      final url = 'https://bpkbautodigital.com/api/payment/checkout';
      final accessToken = _box.read('access_token');
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: {
          'buku_id': bookDetail['id']?.toString() ?? '1',
          'total_amount': totalAmount.value.toString(),
          'address': address,
          'phone': phone,
        },
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return {
            'status': 'success',
            'order_id': data['data']['id'],
            'snap_view_url': data['snap_view_url'],
          };
        }
      } else {
        errorMessage.value = 'Failed with status code: ${response.statusCode}';
      }

      return null;
    } catch (e) {
      errorMessage.value = 'Error creating order: $e';
      return null;
    }
  }

  Future<void> _proceedToPayment(String snapViewUrl) async {
    if (await canLaunch(snapViewUrl)) {
      await launchUrl(
        Uri.parse(snapViewUrl),
        mode: LaunchMode.externalApplication,
      );
    } else {
      errorMessage.value = 'Could not open the URL: $snapViewUrl';
    }
  }

  void calculateTotalWithDiscount() {
    if (selectedVoucher.isNotEmpty) {
      double discountAmountValue =
          (selectedVoucher['discount_amount'] ?? 0).toDouble();
      double discountPercentageValue =
          (selectedVoucher['discount_percentage'] ?? 0).toDouble();

      if (discountPercentageValue > 0) {
        discountAmount.value =
            totalAmount.value * (discountPercentageValue / 100);
      } else {
        discountAmount.value = discountAmountValue;
      }
      finalPrice.value = totalAmount.value - discountAmount.value;
      if (finalPrice.value < 0) {
        finalPrice.value = 0.0;
      }
    } else {
      discountAmount.value = 0.0;
      finalPrice.value = totalAmount.value;
    }
  }

  Future<void> selectAddress() async {
    final result = await Get.toNamed(Routes.ADD_ADDRESS_PAGE);
    if (result != null) {
      selectedAddress.value = result;
      print("Selected address: $selectedAddress");
    }
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['id'] != null) {
      fetchBookDetail(args['id']);
    } else {
      errorMessage.value = 'Book ID not provided';
    }

    ever(selectedAddress, (_) {
      selectedAddress();
    });
    ever(selectedVoucher, (_) {
      calculateTotalWithDiscount();
    });
  }
}
