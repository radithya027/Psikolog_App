import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../infrastructure/theme/theme.dart';
import '../login_page/component/customtextfield.dart';
import 'controllers/biodata_page.controller.dart';

class BiodataPageScreen extends GetView<BiodataPageController> {
  BiodataPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BiodataPageController());

    Widget buildWarningText(bool isValid) {
      return Visibility(
        visible: !isValid,
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 16),
              SizedBox(width: 5),
              Text(
                "This field is required",
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Lengkapi profile kamu',
          style: AppTextStyle.tsTitleBold(AppColor.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceHeightExtraSmall,
                  Container(
                    width: double.infinity,
                    height: heightScreen * 0.04,
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 5),
                      child: Text(
                        "Informasi Umum",
                        style: AppTextStyle.tsSmallBold(AppColor.black),
                      ),
                    ),
                  ),
                  spaceHeightExtraSmall,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Nama Lengkap",
                      style: AppTextStyle.tsNormal,
                    ),
                  ),
                  spaceHeightSmall,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          labelText: "Masukkan nama lengkap sesuai KTP",
                          controller: controller.nameController,
                        ),
                        Obx(() =>
                            buildWarningText(controller.isNameValid.value)),
                      ],
                    ),
                  ),
                  spaceHeightSmall,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Umur",
                      style: AppTextStyle.tsNormal,
                    ),
                  ),
                  spaceHeightSmall,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          labelText: "Umur",
                          controller: controller.ageController,
                        ),
                        Obx(() =>
                            buildWarningText(controller.isAgeValid.value)),
                      ],
                    ),
                  ),
                  spaceHeightSmall,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Alamat",
                      style: AppTextStyle.tsNormal,
                    ),
                  ),
                  spaceHeightSmall,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          labelText: "Alamat",
                          controller: controller.addressController,
                        ),
                        Obx(() =>
                            buildWarningText(controller.isAddressValid.value)),
                      ],
                    ),
                  ),
                  spaceHeightSmall,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Jenis Kelamin",
                      style: AppTextStyle.tsNormal,
                    ),
                  ),
                  Obx(() => Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: Text("Laki-laki",
                                  style: AppTextStyle.tsNormal),
                              value: "laki-laki",
                              groupValue: controller.selectedGender.value,
                              onChanged: (value) {
                                if (value != null)
                                  controller.selectedGender.value = value;
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: Text("Perempuan",
                                  style: AppTextStyle.tsNormal),
                              value: "Perempuan",
                              groupValue: controller.selectedGender.value,
                              onChanged: (value) {
                                if (value != null)
                                  controller.selectedGender.value = value;
                              },
                            ),
                          ),
                        ],
                      )),
                  spaceHeightExtraSmall,
                  Obx(() => GestureDetector(
                        onTap: () {
                          controller.isContactInfoExpanded.value =
                              !controller.isContactInfoExpanded.value;
                        },
                        child: Container(
                          width: double.infinity,
                          height: heightScreen * 0.04,
                          color: Colors.grey[300],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Informasi Kontak",
                                  style:
                                      AppTextStyle.tsSmallBold(AppColor.black),
                                ),
                                Icon(
                                  controller.isContactInfoExpanded.value
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                  Obx(() {
                    if (controller.isContactInfoExpanded.value) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email", style: AppTextStyle.tsNormal),
                            spaceHeightSmall,
                            CustomTextFormField(
                              labelText: "Email",
                              controller: controller.emailController,
                            ),
                            Obx(() => buildWarningText(
                                controller.isEmailValid.value)),
                            spaceHeightSmall,
                            Text("Status", style: AppTextStyle.tsNormal),
                            spaceHeightSmall,
                            CustomTextFormField(
                              labelText: "Status",
                              controller: controller.statusController,
                            ),
                            Obx(() => buildWarningText(
                                controller.isStatusValid.value)),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              height: heightScreen * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  controller.submitProfile();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.button,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  'Simpan',
                  style: AppTextStyle.tsNormal.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
