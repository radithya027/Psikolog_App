import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikolog_app/infrastructure/navigation/routes.dart';
import 'package:psikolog_app/presentation/paymentbook_page/component/customfield.dart';
import '../../infrastructure/theme/theme.dart';
import 'controllers/paymentbook_page.controller.dart';

class PaymentbookPageScreen extends GetView<PaymentbookPageController> {
  const PaymentbookPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(Icons.arrow_back, color: AppColor.blue500),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Checkout',
          style: AppTextStyle.tsTitleBold(AppColor.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text('Item', style: AppTextStyle.tsBodyBold(AppColor.black)),
            const SizedBox(height: 8),
            _buildItemCard(),
            const SizedBox(height: 24),
            Text('Alamat', style: AppTextStyle.tsBodyBold(AppColor.black)),
            const SizedBox(height: 8),
            _buildAddress(),
            const SizedBox(height: 24),
            Text('Total', style: AppTextStyle.tsBodyBold(AppColor.black)),
            const SizedBox(height: 8),
            _buildSummaryCard(),
            const Spacer(),
            _buildTotalPaymentAndButton(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }
      if (controller.bookDetail.isEmpty) {
        return Center(child: Text('No book details available.'));
      }

      final book = controller.bookDetail;
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.network(
              book['image'] ?? '',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book['title'] ?? 'No Title',
                    style: AppTextStyle.tsBodyBold(AppColor.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    book['description'] ?? 'No Description',
                    style: AppTextStyle.tsSmallBold(AppColor.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAddress() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset("lib/infrastructure/assets/icons8-location-48.png"),
          const SizedBox(width: 16),
          InkWell(
            onTap: () async {
              await controller.selectAddress();
            },
            child: Obx(() {
              final address = controller.selectedAddress;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pilih Alamat',
                    style: AppTextStyle.tsBodyBold(AppColor.black),
                  ),
                  SizedBox(height: 4),
                  Text(
                    address['name'] ?? 'Alamat belum dipilih',
                    style: AppTextStyle.tsNormal,
                  ),
                  SizedBox(height: 4),
                  Text(
                    address['address'] ?? '',
                    style: AppTextStyle.tsNormal,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }


  Widget _buildSummaryCard() {
    return Obx(() {
      final price = controller.bookDetail['price']?.toString() ?? '0';
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            _buildSummaryRow('Subtotal (1 item)', 'Rp$price'),
            const Divider(thickness: 1, color: AppColor.blue500),
            _buildSummaryRow('Total', 'Rp$price', isBold: true),
          ],
        ),
      );
    });
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isBold
                ? AppTextStyle.tsBodyBold(AppColor.black)
                : AppTextStyle.tsSmallBold(AppColor.black),
          ),
          Text(
            value,
            style: isBold
                ? AppTextStyle.tsBodyBold(AppColor.black)
                : AppTextStyle.tsSmallBold(AppColor.black),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPaymentAndButton() {
    return Row(
      children: [
        Text(
          'Total Pembayaran',
          style: AppTextStyle.tsSmallRegular(AppColor.black),
        ),
        const Spacer(),
        Obx(() {
          final total = controller.bookDetail['price']?.toString() ?? '0';
          return Text(
            'Rp$total',
            style: AppTextStyle.tsBodyBold(AppColor.black),
          );
        }),
        const SizedBox(width: 16),
        Obx(() => ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.button,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
              onPressed: controller.isLoading.value
                  ? null
                  : () {
                      if (!controller.isOrderCompleted.value) {
                        controller.makeOrder();
                      }
                    },
              child: controller.isLoading.value
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      'Bayar',
                      style: AppTextStyle.tsBodyBold(Colors.white),
                    ),
            )),
      ],
    );
  }
}
