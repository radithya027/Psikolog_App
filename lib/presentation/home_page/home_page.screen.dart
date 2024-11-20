import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikolog_app/infrastructure/navigation/routes.dart';
import 'package:psikolog_app/infrastructure/theme/theme.dart';
import 'package:psikolog_app/presentation/home_page/component/artikel.dart';
import 'package:psikolog_app/presentation/home_page/component/default_appbar.dart';
import 'controllers/home_page.controller.dart';

const List<String> _list = [
  'filter',
  '3day',
  '7day',
  '30day',
];

class HomePageScreen extends GetView<HomePageController> {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Obx(() => DefaultAppbar(
              name: controller.name.value,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defaultHeightSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Promo Menarik",
                style: AppTextStyle.tsBodyBold(AppColor.black),
              ),
            ),
            spaceHeightExtraSmall,
            SizedBox(
              height: heightScreen * 0.2,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 24),
                  itemCount: controller.bannerList.length,
                  itemBuilder: (context, index) {
                    final banner = controller.bannerList[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          banner['image'],
                          width: widthScreen * 0.8,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.broken_image);
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            defaultHeightSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dokter Realtime",
                    style: AppTextStyle.tsBodyBold(AppColor.black),
                  ),
                  Obx(() => controller.realtimeDoctorList.length > 4
                      ? IconButton(
                          icon: Icon(Icons.arrow_forward_rounded),
                          onPressed: () =>
                              Get.toNamed(Routes.DOKTERREALTIME_PAGE),
                        )
                      : SizedBox()),
                ],
              ),
            ),
            spaceHeightSmall,
            SizedBox(
              height: heightScreen * 0.17,
              child: Obx(() {
                if (controller.realtimeDoctorList.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 24),
                    itemCount: controller.realtimeDoctorList.length > 4
                        ? 4
                        : controller.realtimeDoctorList.length,
                    itemBuilder: (context, index) {
                      final doctor = controller.realtimeDoctorList[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(
                                  Routes.SPECIFICDOCTOR_PAGE,
                                  arguments: {'id': doctor['id'].toString()},
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  doctor['profile_picture'] ??
                                      'https://i.pinimg.com/736x/0f/66/51/0f66515be1a0000c08a76d5753009681.jpg',
                                  width: widthScreen * 0.3,
                                  height: heightScreen * 0.14,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: widthScreen * 0.3,
                              child: Text(
                                doctor['name'] ?? 'No Name',
                                style: AppTextStyle.tsNormal,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              }),
            ),
            defaultHeightSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dokter",
                    style: AppTextStyle.tsBodyBold(AppColor.black),
                  ),
                  Obx(() => controller.realtimeDoctorList.length > 4
                      ? IconButton(
                          icon: Icon(Icons.arrow_forward_rounded),
                          onPressed: () =>
                              Get.toNamed(Routes.DOKTERHARIAN_PAGE),
                        )
                      : SizedBox()),
                ],
              ),
            ),
            spaceHeightSmall,
            SizedBox(
              height: heightScreen * 0.17,
              child: Obx(() {
                if (controller.filteredDoctorList.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 24),
                    itemCount: controller.filteredDoctorList.length,
                    itemBuilder: (context, index) {
                      final doctor = controller.filteredDoctorList[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(
                                  Routes.SPECIFICDOCTOR_PAGE,
                                  arguments: {'id': doctor['id'].toString()},
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  doctor['profile_picture'] ??
                                      'https://i.pinimg.com/736x/0f/66/51/0f66515be1a0000c08a76d5753009681.jpg',
                                  width: widthScreen * 0.3,
                                  height: heightScreen * 0.14,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: widthScreen * 0.3,
                              child: Text(
                                doctor['name'] ?? 'No Name',
                                style: AppTextStyle.tsNormal,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              }),
            ),
            defaultHeightSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Buku-buku",
                style: AppTextStyle.tsBodyBold(AppColor.black),
              ),
            ),
            spaceHeightSmall,
            SizedBox(
              height: heightScreen * 0.2,
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.bookList.isEmpty) {
                  return Center(child: Text('No books available'));
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 24),
                  itemCount: controller.bookList.length,
                  itemBuilder: (context, index) {
                    final book = controller.bookList[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Inside HomePageScreen
                          InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.PAYMENTBOOK_PAGE,
                                arguments: {'id': book['id'].toString()},
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                book['image'] ??
                                    'https://example.com/default-image.jpg',
                                width: widthScreen * 0.3,
                                height: heightScreen * 0.14,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.error);
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: 4),
                          Text(
                            book['title'] ?? 'No Title',
                            style: AppTextStyle.tsSmallBold(AppColor.black),
                          ),
                          Text(
                            book['price'].toString() ?? 'No Title',
                            style: AppTextStyle.tsLittle,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
            defaultHeightSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Baca 100+ Artikel Baru",
                style: AppTextStyle.tsBodyBold(AppColor.black),
              ),
            ),
            spaceHeightExtraSmall,
            SizedBox(
              height: heightScreen * 0.31,
              child: Obx(() {
                if (controller.artikelList.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 24),
                    itemCount: controller.artikelList.length,
                    itemBuilder: (context, index) {
                      final article = controller.artikelList[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.DETAIL_ARTICLE_PAGE,
                              arguments: article['id'],
                            );
                          },
                          child: Column(
                            children: [
                              CardArtikel(
                                title:
                                    article['title'] ?? 'Title not available',
                                subtitle: article['subtitle'] ?? 'Tidak ada ',
                                imageUrl: article['image'] ??
                                    'https://example.com/default-image.jpg',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
