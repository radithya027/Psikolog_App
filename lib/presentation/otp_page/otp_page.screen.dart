import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:psikolog_app/infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/theme.dart';
import 'controllers/otp_page.controller.dart';

class OtpPageScreen extends GetView<OtpPageController> {
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.33,
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
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Masukkan OTP',
                        style: AppTextStyle.tsBigTitleBold(AppColor.txtcolor),
                      ),
                      Text(
                        'Selamat datang di Psikolog',
                        style: AppTextStyle.tsBodyRegular(AppColor.black),
                      ),
                      SizedBox(height: 24),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: OtpTextField(
                          numberOfFields: 4,
                          borderColor: AppColor.button,
                          focusedBorderColor: AppColor.txtcolor,
                          showFieldAsBox: true,
                          fieldWidth: 50,
                          keyboardType: TextInputType.number,
                          onSubmit: (String otp) {
                            print("OTP is: $otp");
                          },
                        ),
                      ),
                      SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 50,
                          onPressed: () {
                            Get.toNamed(Routes.RESETPASSWORD_PAGE);
                          },
                          color: AppColor.button,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Reset password",
                                  style:
                                      AppTextStyle.tsSmallBold(AppColor.white)),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Didn’t get OTP?",
                                style: AppTextStyle.tsSmallRegular(
                                    AppColor.black)),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                    color: AppColor.blue500,
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
