import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class TransactionStatusProgresPageController extends GetxController {
  final _box = GetStorage();
  var isLoading = false.obs;
  var name = ''.obs;
  var phoneNumber = ''.obs;
  var detailedAddress = ''.obs;
  var status = ''.obs;
  var createdAt = ''.obs;
  var totalPrice = 0.0.obs;
  var orderId = ''.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    orderId.value =
        _box.read('order_id') ?? ''; // Ambil orderId dari GetStorage
    fetchInvoiceData();
  }

  Future<void> fetchInvoiceData() async {
    if (orderId.isEmpty) {
      print('Order ID tidak ditemukan.');
      return;
    }

    isLoading.value = true;
    try {
      final url = 'https://bpkbautodigital.com/api/payment/invoice/$orderId';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          final invoiceData = data['data'];
          name.value = invoiceData['name'] ?? '';
          phoneNumber.value = invoiceData['phone_number'] ?? '';
          detailedAddress.value = invoiceData['detailed_address'] ?? '';
          status.value = invoiceData['status'] ?? '';
          createdAt.value = invoiceData['created_at'] ?? '';
          totalPrice.value =
              double.tryParse(invoiceData['total_price']?.toString() ?? '0') ??
                  0.0;
        } else {
          print(response.statusCode);
          Get.snackbar('Error', 'Failed to fetch invoice data');
        }
      } else {
        print(response.statusCode);
        Get.snackbar('Error', 'Failed to fetch data from server');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
