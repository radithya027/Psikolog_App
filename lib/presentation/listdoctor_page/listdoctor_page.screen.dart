import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikolog_app/infrastructure/navigation/routes.dart';

import '../../infrastructure/theme/theme.dart';
import 'controllers/listdoctor_page.controller.dart';

class ListdoctorPageScreen extends GetView<ListdoctorPageController> {
  const ListdoctorPageScreen({super.key});

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
          title: Text('Chat dengan dokter',
              style: AppTextStyle.tsTitleBold(AppColor.black)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Filter berdasarkan",
                    style: AppTextStyle.tsBodyBold(AppColor.black),
                  ),
                  Text(
                    "Hapus filter",
                    style: AppTextStyle.tsBodyBold(AppColor.black),
                  )
                ],
              ),
              defaultHeightSpace,
              Divider(
                height: 1,
              ),
              spaceHeightNormal,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      'lib/infrastructure/assets/866e472584a91ce6b6f9f24a966f1057.jpg',
                      width: widthScreen * 0.3,
                      fit: BoxFit.cover,
                    ),
                  ),
                  defaultWidthtSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. Silvana",
                        style: AppTextStyle.tsBodyBold(AppColor.black),
                      ),
                      Text(
                        "Sp.Tronot",
                        style: AppTextStyle.tsSmallRegular(AppColor.black),
                      ),
                      Row(
                        children: [
                          Container(
                            height: heightScreen * 0.025,
                            width: widthScreen * 0.2,
                            decoration: BoxDecoration(
                              color: AppColor.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                "13 tahun",
                                style: AppTextStyle.tsSmallBold(AppColor.black),
                              ),
                            ),
                          ),
                          defaultWidthtSpace,
                          Container(
                            height: heightScreen * 0.025,
                            width: widthScreen * 0.15,
                            decoration: BoxDecoration(
                              color: AppColor.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                "96%",
                                style: AppTextStyle.tsSmallBold(AppColor.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      spaceHeightLarge,
                      Row(
                        children: [
                          Text(
                            "Rp50.000",
                            style: AppTextStyle.tsBodyBold(AppColor.black),
                          ),
                          SizedBox(width: widthScreen * 0.09),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.SPECIFICDOCTOR_PAGE);
                            },
                            child: Container(
                              height: heightScreen * 0.04,
                              width: widthScreen * 0.26,
                              decoration: BoxDecoration(
                                color: AppColor.button,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  "Chat",
                                  style:
                                      AppTextStyle.tsSmallBold(AppColor.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              defaultHeightSpace,
              Divider(
                height: 1,
                color: Colors.grey,
              ),
            ],
          ),
        ));
  }
}
