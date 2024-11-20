import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:psikolog_app/infrastructure/theme/theme.dart';
import 'package:psikolog_app/presentation/login_page/controllers/login_page.controller.dart';

import 'component/customtextfield.dart';

class LoginPageScreen extends GetView<LoginPageController> {
  const LoginPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: widthScreen,
            height: heightScreen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: heightScreen * 0.15,
                  width: widthScreen * 0.33,
                  decoration: BoxDecoration(
                    color: AppColor.colorkey,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Center(
                    child: Image.asset(
                      'lib/infrastructure/assets/goodbye_5821940.png',
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                defaultHeightSpace,
                Padding(
                  padding: EdgeInsets.symmetric(vertical: heightScreen * 0.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Log In',
                        style: AppTextStyle.tsBigTitleBold(AppColor.txtcolor),
                      ),
                      Text(
                        'Selamat datang di Psikolog',
                        style: AppTextStyle.tsBodyRegular(AppColor.black),
                      ),
                      spaceHeightLarge,
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: heightScreen * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              labelText: "Masukkan Nomor Telepon Anda",
                              controller: controller.phoneController,
                            )
                          ],
                        ),
                      ),
                      spaceHeightLarge,
                      Obx(() => SizedBox(
                            width: double.infinity,
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 50,
                              onPressed: () {
                                if (!controller.loading.value) {
                                  controller.login();
                                }
                              },
                              color: AppColor.button,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              elevation: 0,
                              child: controller.loading.value
                                  ? LoadingAnimationWidget.inkDrop(
                                      color: AppColor.white,
                                      size: 24,
                                    )
                                  : Text("Log In",
                                      style: AppTextStyle.tsSmallBold(
                                          AppColor.white)),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
