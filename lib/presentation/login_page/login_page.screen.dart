import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:psikolog_app/infrastructure/navigation/routes.dart';
import 'package:psikolog_app/infrastructure/theme/theme.dart';

import 'component/customtextfield.dart';
import 'controllers/login_page.controller.dart';

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
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Mengatur alignment ke kiri
                          children: [
                            CustomTextFormField(
                              labelText: "Masukkan email anda",
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              isPassword: true,
                              labelText: "Masukkan password anda",
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.FORGOT_PASSWORD_PAGE);
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: AppColor.txtcolor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
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
                              Text("Log In",
                                  style:
                                      AppTextStyle.tsSmallBold(AppColor.white)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Don't have an account? ",
                                style: AppTextStyle.tsSmallRegular(
                                    AppColor.black)),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.REGISTER_PAGE);
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: AppColor.txtcolor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ],
                        ),
                      ),
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
