import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:lottie/lottie.dart';
import '../../infrastructure/navigation/routes.dart';
import '../presentation/authservice/authservice.dart';

class SplashController extends GetxController {
  final _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 3500), checkAuth);
  }

  void checkAuth() {
    if (_authService.isLoggedIn) {
      Get.offAllNamed(Routes.NAVBAR);
    } else {
      Get.offAllNamed(Routes.LOGIN_PAGE);
    }
  }
}

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'lib/infrastructure/lottie/Animation - 1732000208498.json',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'Psikolog',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
