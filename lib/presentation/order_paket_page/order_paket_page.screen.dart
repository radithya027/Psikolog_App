import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikolog_app/infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/theme.dart';
import 'controllers/order_paket_page.controller.dart';

class OrderPaketPageScreen extends StatelessWidget {
  const OrderPaketPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderPaketPageController controller =
        Get.put(OrderPaketPageController());
    final packageData = Get.arguments ?? {};
    final packageTitle = packageData['packageTitle'] ?? 'Default Title';
    final paketType = packageData['paket_type'] ?? 'Default Paket Type';

    // Adjust packagePrice handling to account for both String and double types.
    final packagePrice = packageData['packagePrice'] is double
        ? packageData['packagePrice']
        : double.parse((packageData['packagePrice'] ?? 100000).toString());

    // Initialize the totalAmount in the controller
    controller.totalAmount.value = packagePrice;

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
          color: AppColor.blue500,
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
            _buildItemCard(packageTitle, paketType),
            const SizedBox(height: 24),
            Text('Metode Pembayaran',
                style: AppTextStyle.tsBodyBold(AppColor.black)),
            _buildPaymentMethodCard(),
            const SizedBox(height: 8),
            const SizedBox(height: 24),
            Text('Total', style: AppTextStyle.tsBodyBold(AppColor.black)),
            const SizedBox(height: 8),
            _buildSummaryCard(packagePrice, controller),
            const Spacer(),
            _buildTotalPaymentAndButton(controller),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

Widget _buildSummaryCard(double price, OrderPaketPageController controller) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Obx(() => _buildSummaryRow(
              'Subtotal (1 item)',
              'Rp${controller.totalAmount.value.toStringAsFixed(2)}',
            )),
        Obx(() => controller.selectedVoucher.isNotEmpty
            ? _buildSummaryRow(
                'Discount',
                '-Rp${controller.discountAmount.value.toStringAsFixed(2)}',
              )
            : const SizedBox.shrink()),
        const Divider(thickness: 1, color: AppColor.blue500),
        Obx(() => _buildSummaryRow(
              'Total',
              'Rp${controller.displayPrice.value.toStringAsFixed(2)}',
              isBold: true,
            )),
      ],
    ),
  );
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

Widget _buildPaymentMethodCard() {
  final controller = Get.find<OrderPaketPageController>();

  return InkWell(
    onTap: () => controller.selectVoucher(),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset("lib/infrastructure/assets/icons8-wallet-48.png"),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pilih Voucher',
                    style: AppTextStyle.tsBodyBold(AppColor.black)),
                Obx(() {
                  final voucher = controller.selectedVoucher.value;
                  if (voucher == null) {
                    return Text(
                      'Voucher belum dipilih',
                      style: AppTextStyle.tsNormal,
                    );
                  }

                  // Determine discount text based on what's available
                  String discountText = '';
                  if (voucher['discount_amount'] != null) {
                    discountText = 'Rp${voucher['discount_amount']}';
                  }
                  if (voucher['discount_percentage'] != null) {
                    if (discountText.isNotEmpty) discountText += ' | ';
                    discountText += '${voucher['discount_percentage']}%';
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        voucher['code'] ?? 'No code',
                        style: AppTextStyle.tsNormal.copyWith(
                          color: AppColor.blue500,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: AppColor.black),
        ],
      ),
    ),
  );
}

Widget _buildItemCard(String title, String paketType) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyle.tsBodyBold(AppColor.black)),
            Text(paketType, style: AppTextStyle.tsSmallBold(AppColor.black)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildTotalPaymentAndButton(OrderPaketPageController controller) {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total Pembayaran',
              style: AppTextStyle.tsBodyBold(AppColor.black)),
          const SizedBox(height: 4),
          Obx(() => Text(
                'Rp${controller.displayPrice.value.toStringAsFixed(2)}',
                style: AppTextStyle.tsLittle,
              )),
        ],
      ),
      Spacer(),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        onPressed: () {
          controller.makeOrder();
        },
        child: Text('Bayar', style: AppTextStyle.tsBodyBold(Colors.white)),
      ),
    ],
  );
}
