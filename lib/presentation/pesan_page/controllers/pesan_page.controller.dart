import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:psikolog_app/infrastructure/navigation/routes.dart';

class PesanPageController extends GetxController {
  final _box = GetStorage();
  var chatData = <Map<String, dynamic>>[].obs;
  var userId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    userId.value = Get.arguments['user_id']?.toString() ?? '';
    fetchChatData();
  }

  void fetchChatData() async {
    try {
      final url = 'https://bpkbautodigital.com/api/chat';
      final accessToken = _box.read('access_token');

      if (accessToken == null) {
        print("Access token is missing. Please log in again.");
        return;
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Response Body: ${response.body}');
        final List<dynamic> decodedBody = json.decode(response.body);
        chatData.value =
            decodedBody.map((item) => Map<String, dynamic>.from(item)).toList();
        print('Chat Data Loaded: $chatData');
      } else {
        print('Failed to fetch chat data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching chat data: $e');
    }
  }
}
