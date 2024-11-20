import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikolog_app/infrastructure/theme/theme.dart';
import 'controllers/add_address_page.controller.dart';

class AddAddressPageScreen extends GetView<AddAddressPageController> {
  const AddAddressPageScreen({super.key});

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Daftar Alamat',
          style: AppTextStyle.tsTitleBold(AppColor.black),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Obx(() {
              if (controller.addressList.isEmpty) {
                return Center(child: Text("No addresses available"));
              }

              return ListView.builder(
                itemCount: controller.addressList.length,
                itemBuilder: (context, index) {
                  final address = controller.addressList[index];
                  return GestureDetector(
                    onTap: () async {
                      await controller.fetchSelectedAddress(address['id']);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        color: AppColor.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              address['name'] ?? "",
                              style: AppTextStyle.tsBodyBold(AppColor.black),
                            ),
                            Text(
                              address['phone_number'] ?? "",
                              style: AppTextStyle.tsNormal,
                            ),
                            Text(
                              address['address'] ?? "",
                              style: AppTextStyle.tsNormal,
                            ),
                            Text(
                              address['postal_code'] ?? "",
                              style: AppTextStyle.tsNormal,
                            ),
                            Text(
                              address['note'] ?? "",
                              style: AppTextStyle.tsNormal,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: InkWell(
              onTap: () {
                _showBottomSheet(context);
              },
              child: Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    Image.asset("lib/infrastructure/assets/icons8-add-48.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 24,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(
                  controller: controller.nameController,
                  label: "Nama",
                  hintText: "Masukkan nama",
                  maxLength: 50),
              SizedBox(height: 16),
              _buildTextField(
                  controller: controller.addressController,
                  label: "Alamat",
                  hintText: "Masukkan alamat",
                  maxLength: 100),
              SizedBox(height: 16),
              _buildTextField(
                  controller: controller.postalCodeController,
                  label: "Kode Pos",
                  hintText: "Masukkan Kode Pos",
                  maxLength: 5),
              SizedBox(height: 16),
              _buildTextField(
                  controller: controller.phoneNumberController,
                  label: "Nomor HP",
                  hintText: "Masukkan nomor HP",
                  maxLength: 15),
              SizedBox(height: 16),
              _buildTextField(
                  controller: controller.noteController,
                  label: "Catatan untuk kurir",
                  hintText: "Masukkan catatan",
                  maxLength: 100),
              SizedBox(height: 24),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.addAddress();
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.button,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2, // Adds subtle shadow
                      ),
                      child: Text(
                        'Simpan',
                        style: AppTextStyle.tsBodyBold(AppColor.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required int maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
        ),
        TextFormField(
          controller: controller,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black, fontSize: 16),
            counterText: '',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}
