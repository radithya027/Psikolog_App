import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VoucherPageController extends GetxController {
  final vouchers = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final validatedVoucher = Rxn<Map<String, dynamic>>();
  final validationMessage = RxnString();

  void validateVoucher(String voucherCode) async {
    try {
      isLoading.value = true;
      final url = 'https://bpkbautodigital.com/api/voucher/valid-voucher?code=$voucherCode';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Response data: $data');

        if (data.containsKey('voucher') && data['message'] == 'Voucher is valid') {
          validatedVoucher.value = data['voucher'];
          validationMessage.value = 'Voucher berhasil divalidasi';
          Get.back(result: data['voucher']);
        } else {
          validatedVoucher.value = null;
          validationMessage.value = data['message'] ?? 'Voucher tidak valid';
        }
      } else {
        validatedVoucher.value = null;
        validationMessage.value = 'Gagal memvalidasi voucher';
      }
    } catch (e) {
      validatedVoucher.value = null;
      validationMessage.value = 'Terjadi kesalahan: $e';
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}