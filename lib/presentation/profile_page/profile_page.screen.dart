import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:psikolog_app/infrastructure/theme/theme.dart';

import '../home_page/component/default_appbar.dart';
import 'component/CustomPopup.dart';
import 'component/custombutton.dart';
import 'component/profilelist.dart';
import 'component/profilepicture.dart';
import 'controllers/profile_page.controller.dart';

class ProfilePageScreen extends GetView<ProfilePageController> {
  const ProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              SizedBox(height: 70),
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColor.blue500,
                child: controller.email.isEmpty
                    ? Icon(Icons.person, size: 50, color: Colors.white)
                    : Text(
                        controller.getInitials(),
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Obx(() => Text(controller.name.value,
                      style: AppTextStyle.tsTitleBold(AppColor.black))),
                  Obx(() => Text(controller.status.value,
                      style: AppTextStyle.tsBodyBold(AppColor.blue500))),
                ],
              ),
              spaceHeightNormal,
              Column(
                children: [
                  Obx(() => ProfileList(
                        title: "Nama Lengkap",
                        description: controller.name.value,
                      )),
                  Obx(() => ProfileList(
                        title: "Nomer",
                        description: controller.phoneNumber.value,
                      )),
                  Obx(() => ProfileList(
                        title: "Usia",
                        description: '${controller.age.value} Tahun',
                      )),
                  Obx(() => ProfileList(
                        title: "Status",
                        description: controller.status.value,
                      )),
                  Obx(() => ProfileList(
                        title: "Email",
                        description: controller.email.value,
                      )),
                ],
              ),
              spaceHeightNormal,
              CustomButton(
                text: "Logout",
                colorButton: AppColor.button,
                colorText: AppColor.white,
                onPressed: () {
                  showCustomPopupDialog(
                    "Keluar Akun",
                    "Apakah Anda yakin ingin keluar akun?",
                    [
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          "Tidak",
                          style: AppTextStyle.tsBodyRegular(AppColor.black),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColor.blue500)),
                        onPressed: () => controller.logout(),
                        child: Text(
                          "Iya, Keluar",
                          style: AppTextStyle.tsBodyRegular(AppColor.white),
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
