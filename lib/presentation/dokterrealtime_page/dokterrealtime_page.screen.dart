import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikolog_app/infrastructure/theme/theme.dart';
import 'package:psikolog_app/infrastructure/navigation/routes.dart';
import 'controllers/dokterrealtime_page.controller.dart';

class DokterrealtimePageScreen extends GetView<DokterrealtimePageController> {
  const DokterrealtimePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
          color: AppColor.blue500,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Realtime',
          style: AppTextStyle.tsTitleBold(AppColor.black),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.realtimeDoctorList.isEmpty) {
          return Center(child: Text('No doctors available'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7, // Adjusted for more height
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: controller.realtimeDoctorList.length,
          itemBuilder: (context, index) {
            final doctor = controller.realtimeDoctorList[index];
            return InkWell(
              onTap: () {
                Get.toNamed(
                  Routes.SPECIFICDOCTOR_PAGE,
                  arguments: {'id': doctor['id'].toString()},
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5, // Allocate more space for image
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        child: Image.network(
                          doctor['profile_picture'] ??
                              'https://i.pinimg.com/736x/0f/66/51/0f66515be1a0000c08a76d5753009681.jpg',
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: Icon(Icons.error),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3, // Allocate less space for text
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              doctor['name'] ?? 'No Name',
                              style: AppTextStyle.tsBodyBold(AppColor.black),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              doctor['experience'] ?? 'No Experience',
                              style: AppTextStyle.tsNormal,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        
                            const SizedBox(height: 2),
                            Text(
                              doctor['ages'].toString() ?? 'No Experience',
                              style: AppTextStyle.tsNormal,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (doctor['specialization'] != null)
                              Text(
                                doctor['specialization'],
                                style: AppTextStyle.tsNormal.copyWith(
                                  color: AppColor.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
