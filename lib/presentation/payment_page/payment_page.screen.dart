import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikolog_app/infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/theme.dart';
import 'controllers/payment_page.controller.dart';

class PaymentPageScreen extends GetView<PaymentPageController> {
  const PaymentPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;

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
          'Ringkasan pembayaran',
          style: AppTextStyle.tsTitleBold(AppColor.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(height: 2),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image and Doctor Details
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            'lib/infrastructure/assets/866e472584a91ce6b6f9f24a966f1057.jpg',
                            width: widthScreen * 0.2,
                            height: heightScreen * 0.11,
                            fit: BoxFit.cover,
                          ),
                        ),
                        defaultWidthtSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dr Silvana kafila",
                              style: AppTextStyle.tsTextContainer,
                            ),
                            spaceHeightExtraSmall,
                            Text("Sp. Tronot", style: AppTextStyle.tsNormal),
                            Row(
                              children: [
                                Text("STR", style: AppTextStyle.tsNormal),
                                defaultHeightSpace,
                                SizedBox(width: 100),
                                Text(
                                  "NI00000303969934",
                                  style: AppTextStyle.tsNormal
                                      .copyWith(color: Colors.grey[500]),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(height: 5, color: Colors.grey[300]),
                  spaceHeightNormal,
                  // Payment Summary Rows
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Biaya sesi 30 Menit",
                            style: AppTextStyle.tsNormal),
                        Text(
                          "Rp56.000",
                          style: AppTextStyle.tsNormal
                              .copyWith(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Biaya layanan", style: AppTextStyle.tsNormal),
                        Text(
                          "-Rp56.000",
                          style: AppTextStyle.tsNormal
                              .copyWith(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Kupon", style: AppTextStyle.tsNormal),
                        Text(
                          "-Rp56.000",
                          style: AppTextStyle.tsNormal
                              .copyWith(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pembayaranmu", style: AppTextStyle.tsNormal),
                        Text(
                          "Rp56.000",
                          style: AppTextStyle.tsNormal
                              .copyWith(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  spaceHeightSmall,
                  Container(height: 5, color: Colors.grey[300]),
                  spaceHeightSmall,
                  // Promo Code Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      height: heightScreen * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: Colors.grey,
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                              "lib/infrastructure/assets/icons8-discount-100.png"),
                          defaultWidthtSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  "Pakai Kupon & makin Hemat!",
                                  style:
                                      AppTextStyle.tsSmallBold(AppColor.black),
                                ),
                              ),
                              Text(
                                "Temukan promo menarik disini",
                                style:
                                    AppTextStyle.tsSmallRegular(AppColor.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  spaceHeightSmall,
                  Container(height: 5, color: Colors.grey[300]),
                  defaultHeightSpace,
                  // Payment Method Selection with TabBar and TabBarView
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Pilih metode pembayaran",
                      style: AppTextStyle.tsBodyBold(AppColor.black),
                    ),
                  ),
                  spaceHeightSmall,
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          indicatorColor: AppColor.blue500,
                          labelColor: AppColor.blue500,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(text: "Uang Elektronik"),
                            Tab(text: "Kartu Kredit/Debit"),
                          ],
                        ),
                        SizedBox(
                          height: heightScreen * 0.2,
                          child: TabBarView(
                            children: [
                              Center(
                                child: Text(
                                  "Content for Uang Elektronik",
                                  style: AppTextStyle.tsNormal,
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Content for Kartu Kredit/Debit",
                                  style: AppTextStyle.tsNormal,
                                ),
                              ),
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
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pembayaranmu",
                      style: AppTextStyle.tsNormal
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Rp56.000",
                      style: AppTextStyle.tsBodyBold(AppColor.black),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.offAndToNamed(Routes.CHAT_PAGE);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      color: AppColor.blue500,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Lanjutkan",
                      style: AppTextStyle.tsBodyBold(AppColor.background),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
