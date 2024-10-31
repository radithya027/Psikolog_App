import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:psikolog_app/infrastructure/navigation/navigation.dart';
import 'package:psikolog_app/infrastructure/navigation/routes.dart';



void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: Routes.LOGIN_PAGE,
      getPages: Nav.routes,
    ),
  );
}
