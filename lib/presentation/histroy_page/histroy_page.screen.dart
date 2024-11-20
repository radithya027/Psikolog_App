import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:psikolog_app/infrastructure/theme/theme.dart';
import 'controllers/histroy_page.controller.dart';

class HistroyPageScreen extends GetView<HistroyPageController> {
  const HistroyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Riwayat Transaksi',
              style: AppTextStyle.tsTitle,
            ),
            Obx(() => DropdownButton<String>(
                  value: controller.selectedFilter.value,
                  style: AppTextStyle.tsTitle.copyWith(color: AppColor.blue500),
                  underline: Container(), // Removes the default underline
                  items: [
                    DropdownMenuItem(value: 'semua', child: Text('Semua')),
                    DropdownMenuItem(value: 'buku', child: Text('Buku')),
                    DropdownMenuItem(value: 'paket', child: Text('Paket')),
                  ],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.updateFilter(newValue);
                    }
                  },
                )),
          ],
        ),
        centerTitle: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.historyList.isEmpty) {
          return Column(
            children: [
              Divider(height: 1),
              SizedBox(height: 150),
              Center(
                child: Lottie.asset(
                  "lib/infrastructure/lottie/Animation - 1732001792674.json",
                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              // defaultHeightSpace,
              // Text(
              //   "Belum Ada Pesanan untuk Profile Ini",
              //   style: AppTextStyle.tsBodyBold(AppColor.black),
              // ),
            ],
          );
        } else {
          return ListView.builder(
            itemCount: controller.historyList.length,
            itemBuilder: (context, index) {
              final item = controller.historyList[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ID: ${item.id}",
                      style: AppTextStyle.tsBodyBold(AppColor.black),
                    ),
                    SizedBox(height: 4),
                    Text("Total Harga: Rp ${item.totalPrice}"),
                    SizedBox(height: 4),
                    Text("Status: ${item.status}"),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
