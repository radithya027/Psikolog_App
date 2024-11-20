import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:psikolog_app/infrastructure/navigation/routes.dart';

import '../../infrastructure/theme/theme.dart';
import 'controllers/lainnya_page.controller.dart';

class LainnyaPageScreen extends GetView<LainnyaPageController> {
  const LainnyaPageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pesan',
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
        }
        return ListView.builder(
          itemCount: controller.chatData.length,
          itemBuilder: (context, index) {
            var chat = controller.chatData[index];
            if (chat['participants'] == null) {
              return SizedBox.shrink();
            }
            var doctorParticipant = chat['participants']?.firstWhere(
              (participant) => participant['user']?['role'] == 'dokter',
              orElse: () => null,
            );
            if (doctorParticipant == null) return SizedBox.shrink();

            var doctorName =
                doctorParticipant['user']?['name'] ?? 'Unknown Doctor';
            var profilePicUrl =
                doctorParticipant['user']?['name'] ?? 'Unknown Doctor';

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(profilePicUrl),
              ),
              title: Text(
                doctorName,
                style: AppTextStyle.tsBodyBold(AppColor.black),
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
