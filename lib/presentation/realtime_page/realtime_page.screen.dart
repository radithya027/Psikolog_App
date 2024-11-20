import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import 'controllers/realtime_page.controller.dart';

class RealtimePageScreen extends GetView<RealtimePageController> {
  const RealtimePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.blue[500],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Detail Dokter',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Container(
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
                      child: Image.asset(
                        'lib/infrastructure/assets/866e472584a91ce6b6f9f24a966f1057.jpg',
                        width: widthScreen,
                        height: widthScreen * 0.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "Online",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Nama tidak tersedia',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Spesialis tidak tersedia",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "Rp55.000",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[500],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Additional Info Section
              Container(
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
                      imagePath:
                          "lib/infrastructure/assets/icons8-school-100.png",
                      label: "Alumnus",
                      value: "Universitas tidak tersedia",
                    ),
                    Divider(height: 24),
                    _buildInfoRow(
                      imagePath:
                          "lib/infrastructure/assets/icons8-hospital-100.png",
                      label: "Praktik di",
                      value: "RSU Bhakti Rahayu, Tabanan, Bali",
                    ),
                    Divider(height: 24),
                    _buildInfoRow(
                      imagePath:
                          "lib/infrastructure/assets/icons8-document-100.png",
                      label: "Nomor STR",
                      value: "STR tidak tersedia",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Chat Button
              SizedBox(
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
                    // Replace with your action
                  },
                  child: Text(
                    "Chat",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      {required String imagePath,
      required String label,
      required String value}) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 24,
          height: 24,
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
