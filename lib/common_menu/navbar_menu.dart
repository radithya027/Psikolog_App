import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:psikolog_app/presentation/home_page/home_page.screen.dart';
import 'package:psikolog_app/presentation/screens.dart';

import '../../infrastructure/theme/theme.dart';

class NavbarMenu extends StatelessWidget {
  const NavbarMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          backgroundColor: AppColor.background,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(IconsaxPlusBold.home),
              selectedIcon: Icon(
                IconsaxPlusBold.home,
                color: AppColor.blue500,
              ),
              label: "Beranda",
            ),
            NavigationDestination(
              icon: Icon(IconsaxPlusBold.archive_book),
              selectedIcon: Icon(
                IconsaxPlusBold.archive_book,
                color: AppColor.blue500,
              ),
              label: "Riwayat",
            ),
            NavigationDestination(
              icon: Icon(IconsaxPlusBold.profile),
              selectedIcon: Icon(
                IconsaxPlusBold.profile,
                color: AppColor.blue500,
              ),
              label: "Profile",
            ),
            NavigationDestination(
              icon: Icon(IconsaxPlusBold.category),
              selectedIcon: Icon(
                IconsaxPlusBold.category,
                color: AppColor.blue500,
              ),
              label: "Chat",
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    HomePageScreen(),
    HistroyPageScreen(),
    ProfilePageScreen(),
    LainnyaPageScreen()
  ];
}
