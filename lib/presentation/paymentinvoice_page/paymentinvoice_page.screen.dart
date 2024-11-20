import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/paymentinvoice_page.controller.dart';

class PaymentinvoicePageScreen extends GetView<PaymentinvoicePageController> {
  const PaymentinvoicePageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaymentinvoicePageScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaymentinvoicePageScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
