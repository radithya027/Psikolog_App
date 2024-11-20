import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:psikolog_app/infrastructure/navigation/routes.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class OrderPaketPageController extends GetxController {
  var selectedVoucher = {}.obs;
  var selectedAddress = {}.obs;
  var discountAmount = 0.0.obs;
  final _box = GetStorage();
  var finalPrice = 0.0.obs;
  var totalAmount = 100000.0.obs;
  var finalAmount = 0.0.obs;
  var isLoading = false.obs;
  var displayPrice = 0.0.obs;
  var errorMessage = ''.obs;
  var orderId = ''.obs;
  var isOrderCompleted = false.obs;
  var paketId = ''.obs;

  final phoneController = TextEditingController();
  final alamatController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      if (args.containsKey('packageId')) {
        paketId.value = args['packageId'].toString();
      }
      // Mengambil total amount dari arguments jika tersedia
      if (args.containsKey('packagePrice')) {
        final price = args['packagePrice'];
        if (price is double) {
          totalAmount.value = price;
        } else if (price is String) {
          totalAmount.value = double.tryParse(price) ?? 0.0;
        } else if (price is int) {
          totalAmount.value = price.toDouble();
        }
        // Set display price awal sama dengan total amount
        displayPrice.value = totalAmount.value;
      } else {
        // Jika tidak ada di arguments, ambil dari API
        fetchPaketDetails();
      }
    }
    ever(selectedVoucher, (_) => calculateTotalWithDiscount());
  }

  Future<void> fetchPaketDetails() async {
    isLoading.value = true;
    try {
      final accessToken = _box.read('access_token');
      final response = await http.get(
        Uri.parse('https://bpkbautodigital.com/api/paket/${paketId.value}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          final price = data['data']['price'];
          if (price != null) {
            if (price is num) {
              totalAmount.value = price.toDouble();
            } else if (price is String) {
              totalAmount.value = double.tryParse(price) ?? 0.0;
            }
            // Set display price setelah mendapatkan total amount
            displayPrice.value = totalAmount.value;
            calculateTotalWithDiscount();
          }
        } else {
          errorMessage.value = 'Failed to load package details';
        }
      } else {
        errorMessage.value = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching package details: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectVoucher() async {
    final result = await Get.toNamed(Routes.VOUCHER_PAGE);
    if (result != null) {
      selectedVoucher.value = result;
      calculateTotalWithDiscount();
    }
  }

  void calculateTotalWithDiscount() {
    if (totalAmount.value == 0.0) {
      print(
          "Total amount is zero. Set a value for totalAmount before calculating discount.");
      return;
    }

    if (selectedVoucher.isNotEmpty) {
      double discountPercentageValue =
          (selectedVoucher['discount_percentage'] ?? 0).toDouble();
      discountAmount.value =
          totalAmount.value * (discountPercentageValue / 100);
      finalPrice.value = totalAmount.value - discountAmount.value;
      if (finalPrice.value < 0) finalPrice.value = 0.0;
      // Update display price to show final price when voucher is applied
      displayPrice.value = finalPrice.value;
    } else {
      discountAmount.value = 0.0;
      finalPrice.value = totalAmount.value;
      // Reset display price to original amount when no voucher
      displayPrice.value = totalAmount.value;
    }
  }

  Future<void> makeOrder() async {
    isLoading.value = true;
    isOrderCompleted.value = false;
    try {
      var orderResponse = await _createOrder(
        address: alamatController.text,
        phone: phoneController.text,
        paketId: paketId.value,
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
    required String paketId,
  }) async {
    try {
      final url = 'https://bpkbautodigital.com/api/payment/checkout-paket';
      final accessToken = _box.read('access_token');
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: {
          'paket_id': paketId,
          'total_amount': totalAmount.value.toString(),
          'voucher_code': selectedVoucher['code'] ?? '',
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

  void _proceedToPayment(String snapViewUrl) {
    _launchURL(snapViewUrl);
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      errorMessage.value = 'Could not open the URL: $url';
    }
  }
}
