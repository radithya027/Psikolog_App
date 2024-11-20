import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikolog_app/infrastructure/navigation/routes.dart';
import 'package:psikolog_app/presentation/screens.dart';
import 'package:psikolog_app/presentation/specificdoctor_page/controllers/specificdoctor_page.controller.dart';
import '../../infrastructure/theme/theme.dart';

class SpecificdoctorPageScreen extends GetView<SpecificdoctorPageController> {
  const SpecificdoctorPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Colors.blue),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Detail Dokter',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final doctor = controller.doctorDetail.value;
          if (doctor == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDoctorHeader(doctor, widthScreen),
                SizedBox(height: 16),
                _buildDetailInfoSection(doctor),
                SizedBox(height: 16),
                _buildChatButton(context, widthScreen),
                SizedBox(height: 16),
                _buildChatButtonTest(context, widthScreen)
              ],
            );
          }
        }),
      ),
    );
  }

  Widget _buildDoctorHeader(Map<String, dynamic> doctor, double widthScreen) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              doctor['profile_picture'] ??
                  'https://i.pinimg.com/736x/0f/66/51/0f66515be1a0000c08a76d5753009681.jpg',
              height: heightScreen * 0.3,
              width: widthScreen,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error);
              },
            ),
          ),
          SizedBox(height: 8),
          Text(
            doctor['name'] ?? 'N/A',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            doctor['experience'] ?? 'N/A',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            "Rating: ${doctor['rating'] ?? 0}",
            style: TextStyle(
                color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailInfoSection(Map<String, dynamic> doctor) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            imagePath: "lib/infrastructure/assets/icons8-school-100.png",
            label: "Alumnus",
            value: doctor['school'] ?? 'N/A',
          ),
          Divider(height: 24),
          _buildInfoRow(
            imagePath: "lib/infrastructure/assets/icons8-hospital-100.png",
            label: "Praktik di",
            value: doctor['address'] ?? 'N/A',
          ),
          Divider(height: 24),
          _buildInfoRow(
            imagePath: "lib/infrastructure/assets/icons8-document-100.png",
            label: "Nomor STR",
            value: doctor['str_number']?.toString() ?? 'N/A',
          ),
        ],
      ),
    );
  }

  Widget _buildChatButtonTest(BuildContext context, double widthScreen) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.button,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          controller.createChat();
        },
        child: Text(
          "Chat",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildChatButton(BuildContext context, double widthScreen) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Pilih paket untuk konsultasi",
                          style: AppTextStyle.tsBodyBold(AppColor.black),
                        ),
                        defaultHeightSpace,
                        Obx(() {
                          if (controller.packages.isEmpty) {
                            return Center(
                              child: Text(
                                "Tidak ada paket untuk dokter ini",
                                style: AppTextStyle.tsNormal,
                              ),
                            );
                          }

                          return Column(
                            children: controller.packages.map((package) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.ORDER_PAKET_PAGE,
                                        arguments: {
                                          'packageId': package['id'],
                                          'packageTitle': package['title'],
                                          'packagePrice': package['price'],
                                          'paket_type': package['paket_type']
                                        },
                                      );
                                    },
                                    child: _buildInfoRow(
                                      imagePath:
                                          'lib/infrastructure/assets/icons8-realtime-64 (1).png',
                                      label: package['paket_type'] ?? 'Unknown',
                                      value: package['title'] ?? 'Unknown',
                                    ),
                                  ),
                                  Divider(height: 24),
                                ],
                              );
                            }).toList(),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Text(
          "Pembayaran",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required String imagePath,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          scale: 2,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Text(value, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
