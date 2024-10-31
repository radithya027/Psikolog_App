import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:psikolog_app/infrastructure/navigation/routes.dart';

import '../../infrastructure/theme/theme.dart';
import '../login_page/component/customtextfield.dart';
import 'controllers/register_page.controller.dart';

class RegisterPageScreen extends GetView<RegisterPageController> {
  const RegisterPageScreen({super.key});
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
                      'lib/infrastructure/assets/clap_9971688.png',
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
                        'Register',
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
                            CustomTextFormField(
                              labelText: "Masukkan email anda",
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              labelText: "Masukkan Nomer telepon anda",
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              isPassword: true,
                              labelText: "Masukkan password anda",
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
                              Text(
                                "Register",
                                style: AppTextStyle.tsTitle.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              defaultWidthtSpace,
                              const Icon(
                                size: 20,
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              ),
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
                            Text("Do you have a account?",
                                style: AppTextStyle.tsSmallRegular(
                                    AppColor.black)),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.LOGIN_PAGE);
                                },
                                child: Text(
                                  "Log In",
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
