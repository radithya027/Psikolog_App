import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:psikolog_app/infrastructure/navigation/routes.dart';

import '../../infrastructure/theme/theme.dart';
import '../login_page/component/customtextfield.dart';
import 'controllers/forgot_password_page.controller.dart';

class ForgotPasswordPageScreen extends GetView<ForgotPasswordPageController> {
  const ForgotPasswordPageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: AppColor.blue500,
        ),
      ),
      body: Center(
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
                      'lib/infrastructure/assets/speech-bubble_2598981.png',
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                defaultHeightSpace,
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: heightScreen * 0.02),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Text(
                //         'Lupa Password',
                //         style: AppTextStyle.tsBigTitleBold(AppColor.txtcolor),
                //       ),
                //       Text(
                //         'Selamat datang di Psikolog',
                //         style: AppTextStyle.tsBodyRegular(AppColor.black),
                //       ),
                //       spaceHeightLarge,
                //       Container(
                //         margin:
                //             EdgeInsets.symmetric(vertical: heightScreen * 0.02),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment
                //               .start, // Mengatur alignment ke kiri
                //           children: [
                //             CustomTextFormField(
                //               labelText: "Masukkan email anda",
                //             ),
                //           ],
                //         ),
                //       ),
                //       spaceHeightLarge,
                //       SizedBox(
                //         width: double.infinity,
                //         child: MaterialButton(
                //           minWidth: double.infinity,
                //           height: 50,
                //           onPressed: () {
                //             Get.toNamed(Routes.OTP_PAGE);
                //           },
                //           color: AppColor.button,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.all(Radius.circular(12)),
                //           ),
                //           elevation: 0,
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Text("Lanjut",
                //                   style:
                //                       AppTextStyle.tsSmallBold(AppColor.white)),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
