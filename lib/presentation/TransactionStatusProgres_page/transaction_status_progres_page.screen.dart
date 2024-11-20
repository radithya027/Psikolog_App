import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/transaction_status_progres_page.controller.dart';

class TransactionStatusProgresPageScreen extends GetView<TransactionStatusProgresPageController> {
  const TransactionStatusProgresPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const CircularProgressIndicator();
            }

            if (controller.errorMessage.value.isNotEmpty) {
              return Center(
                child: Text(
                  controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red, fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Success Icon
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 48.0,
                  ),
                ),
                const SizedBox(height: 16.0),

                // Payment Status Text
                const Text(
                  "Payment successful",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Successfully paid \$${controller.totalPrice.value.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 24.0),

                // Payment Method Details
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow("Name", controller.name.value),
                      const SizedBox(height: 8.0),
                      _buildDetailRow("Phone Number", controller.phoneNumber.value),
                      const SizedBox(height: 8.0),
                      _buildDetailRow("Address", controller.detailedAddress.value),
                      const SizedBox(height: 8.0),
                      _buildDetailRow("Status", controller.status.value, statusIcon: true),
                      const SizedBox(height: 8.0),
                      _buildDetailRow("Created At", controller.createdAt.value),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),

                // Total Payment Row
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "\$${controller.totalPrice.value.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, {bool statusIcon = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black54,
          ),
        ),
        Row(
          children: [
            if (statusIcon)
              Container(
                margin: const EdgeInsets.only(right: 4.0),
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 16.0,
                ),
              ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
