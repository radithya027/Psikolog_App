import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final _box = GetStorage();
  
  bool get isLoggedIn => _box.hasData('access_token');
  String? get accessToken => _box.read('access_token');
  
  void saveToken(String token) {
    _box.write('access_token', token);
  }
  
  void clearToken() {
    _box.remove('access_token');
  }
  
}