import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikolog_app/infrastructure/theme/theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:psikolog_app/presentation/edit_address_page/controllers/edit_address_page.controller.dart';

class EditAddressPageScreen extends GetView<EditAddressPageController> {
  const EditAddressPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Detail Alamat',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            _buildTextField(
              controller: controller.addressController,
              label: 'Alamat Lengkap',
              hintText: 'A, Kandang Mas, Kp. Melayu, Kota Bengkulu, Ber',
              maxLength: 200,
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: controller.postalCodeController,
              label: 'Kode Pos',
              hintText: 'A, Kandang Mas, Kp. Melayu, Kota Bengkulu, Ber',
              maxLength: 200,
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: controller.noteController,
              label: 'Catatan Untuk Kurir (Opsional)',
              hintText: 'Warna rumah, patokan, pesan khusus, dll',
              maxLength: 45,
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: controller.nameController,
              label: 'Nama Penerima',
              hintText: 'Fatih Abdurrahman Didar',
              maxLength: 50,
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: controller.phoneNumberController,
              label: 'Nomor Hp',
              hintText: '6281367388484',
              maxLength: 15,
            ),
            SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                      children: [
                        TextSpan(
                            text:
                                'Dengan klik tombol di bawah, kamu menyetujui '),
                        TextSpan(
                          text: 'Syarat & Ketentuan ',
                          style: TextStyle(
                              color: AppColor.blue500,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: 'serta '),
                        TextSpan(
                          text: 'Kebijakan Privasi ',
                          style: TextStyle(
                              color: AppColor.blue500,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: 'pengaturan alamat di Tokopedia.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Center(
              child: Obx(
                () => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller
                          .updateAddress, // Disable button while loading
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.button,
                    padding:
                        EdgeInsets.symmetric(horizontal: 150, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? LoadingAnimationWidget.inkDrop(
                          color: AppColor.white,
                          size: 24,
                        )
                      : Text(
                          'Simpan',
                          style: AppTextStyle.tsBodyBold(AppColor.white),
                        ),
                ),
              ),
            ),
          ],
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
              borderSide: BorderSide(color: AppColor.blue500),
            ),
          ),
        ),
      ],
    );
  }
}
