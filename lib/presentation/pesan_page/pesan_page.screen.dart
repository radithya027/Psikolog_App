import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikolog_app/infrastructure/navigation/routes.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/theme/theme.dart';
import 'controllers/pesan_page.controller.dart';

class PesanPageScreen extends GetView<PesanPageController> {
  PesanPageScreen({super.key});

  String formatExpiryDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'No expiry date';
    try {
      // Format custom dari API
      DateTime date = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateString);
      return DateFormat('yyyy MMM dd, hh:mm a').format(date);
    } catch (e) {
      print('Error parsing date: $e');
      return 'Invalid date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inbox',
          style: AppTextStyle.tsTitle,
        ),
        centerTitle: false,
      ),
      body: Obx(() {
        if (controller.chatData.isEmpty) {
          return Column(
            children: [
              Divider(height: 1),
              SizedBox(height: 150),
              Center(
                child: Image.asset(
                  "lib/infrastructure/assets/3024051-removebg-preview.png",
                  scale: 3,
                ),
              ),
              defaultHeightSpace,
              Text(
                "Belum Ada Pesanana untuk Profile Ini",
                style: AppTextStyle.tsBodyBold(AppColor.black),
              ),
              spaceHeightExtraSmall,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Belum ada riwayat pesanan Psikolog untuk profile yang\nterpilih, buat pesanan melalui layanan kami",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.tsSmallRegular(AppColor.black),
                ),
              ),
            ],
          );
        }

        return ListView.builder(
          itemCount: controller.chatData.length,
          itemBuilder: (context, index) {
            var chat = controller.chatData[index];
            var expiryDate = chat['expiry_date'];
            print('Chat Data [Index $index]: $chat');
            print('Expiry Date [Index $index]: $expiryDate');

            if (chat['participants'] == null) {
              return SizedBox.shrink();
            }

            var doctorParticipant = chat['participants']?.firstWhere(
              (participant) => participant['user']?['role'] == 'dokter',
              orElse: () => null,
            );
            if (doctorParticipant == null) return SizedBox.shrink();

            // Ambil data dokter
            var doctorName =
                doctorParticipant['user']?['name'] ?? 'Unknown Doctor';
            var profilePicUrl =
                doctorParticipant['user']?['profile_picture'] ?? '';

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: profilePicUrl.isNotEmpty
                    ? NetworkImage(profilePicUrl)
                    : null,
                child: profilePicUrl.isEmpty ? Icon(Icons.person) : null,
              ),
              title: Text(
                doctorName,
                style: AppTextStyle.tsBodyBold(AppColor.black),
              ),
              subtitle: Text(
                '${formatExpiryDate(expiryDate)}',
                style: AppTextStyle.tsSmallRegular(AppColor.black),
              ),
              onTap: () {
                Get.toNamed(
                  Routes.CHAT_PAGE,
                  arguments: {'id': chat['id'].toString()},
                );
              },
            );
          },
        );
      }),
    );
  }
}
