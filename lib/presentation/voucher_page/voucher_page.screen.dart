import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import 'controllers/voucher_page.controller.dart';

class VoucherPageScreen extends GetView<VoucherPageController> {
  const VoucherPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: AppColor.blue500,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Voucher',
          style: AppTextStyle.tsTitleBold(AppColor.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextFormField(
              onFieldSubmitted: (value) {
                controller.validateVoucher(value);
              },
              decoration: InputDecoration(
                labelText: 'Cari Voucher',
                hintText: 'Masukkan kode voucher',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.validatedVoucher.value != null) {
                  final voucher = controller.validatedVoucher.value!;
                  return ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Return the validated voucher to previous screen
                          Get.back(result: voucher);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColor.blue500,
                              width: 2.0,
                            ),
                            color: AppColor.background,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Voucher Tervalidasi',
                                style: AppTextStyle.tsTitleBold(AppColor.black),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Kode: ${voucher['code'] ?? 'No code'}',
                                style: AppTextStyle.tsTextContainer,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Diskon: ${voucher['discount_percentage'] != null ? '${voucher['discount_percentage']}%' : 'N/A'}',
                                style: AppTextStyle.tsTitle,
                              ),
                              const SizedBox(height: 8),
                              Divider(),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'Berlaku hingga: ${voucher['expiry_date'] ?? 'Tidak ada batas'}',
                                  style: AppTextStyle.tsNormal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Center(child: Text("Tidak ada voucher tersedia"));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
