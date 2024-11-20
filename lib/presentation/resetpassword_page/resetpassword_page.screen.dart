import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../login_page/component/customtextfield.dart';
import 'controllers/resetpassword_page.controller.dart';

class ResetpasswordPageScreen extends GetView<ResetpasswordPageController> {
  const ResetpasswordPageScreen({super.key});
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
                    color: AppColor.grey,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Center(
                    child: Image.asset(
                      'lib/infrastructure/assets/lock_4822441.png',
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
                        'Buat Kata Sandi Baru',
                        style: AppTextStyle.tsBigTitleBold(AppColor.txtcolor),
                      ),
                      Text(
                        'Silah kan Register terlebih dahulu',
                        style: AppTextStyle.tsBodyRegular(AppColor.black),
                      ),
                      spaceHeightLarge,
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: heightScreen * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // CustomTextFormField(
                            //   isPassword: true,
                            //   labelText: "Masukkan password baru",
                            // ),
                            const SizedBox(height: 20),
                            // CustomTextFormField(
                            //   isPassword: true,
                            //   labelText: "Konfrimasi password baru anda",
                            // ),
                          ],
                        ),
                      ),
                      spaceHeightLarge,
                      SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 50,
                          onPressed: () {},
                          color: AppColor.button,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Reset",
                                style: AppTextStyle.tsTitle.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
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
