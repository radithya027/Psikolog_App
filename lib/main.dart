import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:psikolog_app/infrastructure/navigation/bindings/initial_binding.dart';
import 'package:psikolog_app/presentation/firebase/firebase_options.dart';
import 'package:psikolog_app/infrastructure/navigation/navigation.dart';
import 'package:psikolog_app/infrastructure/navigation/routes.dart';
import 'package:psikolog_app/presentation/paymentbook_page/controllers/paymentbook_page.controller.dart';
import 'package:psikolog_app/presentation/pesan_page/controllers/pesan_page.controller.dart';
import 'presentation/authservice/authservice.dart';
import 'presentation/firebase/firebase_api.dart';
import 'presentation/order_paket_page/controllers/order_paket_page.controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthService());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseApi().initNotifications();

  await GetStorage.init();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialBinding: InitialBinding(),
      getPages: Nav.routes,
      initialRoute: Routes.INITIAL,
      debugShowCheckedModeBanner: false,
    ),
  );
}
