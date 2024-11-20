import 'package:get/get.dart';
import '../../../presentation/authservice/authservice.dart';


class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService(), permanent: true);
    // Tambahkan dependencies lain yang dibutuhkan saat startup
  }
}
