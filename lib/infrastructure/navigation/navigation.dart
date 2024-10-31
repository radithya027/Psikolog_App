import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:psikolog_app/app/config.dart';

import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  EnvironmentsBadge({required this.child});
  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.LOGIN_PAGE,
      page: () => const LoginPageScreen(),
      binding: LoginPageControllerBinding(),
    ),
    GetPage(
      name: Routes.REGISTER_PAGE,
      page: () => const RegisterPageScreen(),
      binding: RegisterPageControllerBinding(),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD_PAGE,
      page: () => const ForgotPasswordPageScreen(),
      binding: ForgotPasswordPageControllerBinding(),
    ),
    GetPage(
      name: Routes.OTP_PAGE,
      page: () => OtpPageScreen(),
      binding: OtpPageControllerBinding(),
    ),
    GetPage(
      name: Routes.RESETPASSWORD_PAGE,
      page: () => const ResetpasswordPageScreen(),
      binding: ResetpasswordPageControllerBinding(),
    ),
  ];
}
