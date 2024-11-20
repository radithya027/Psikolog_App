import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:psikolog_app/infrastructure/navigation/routes.dart';

class SpecificdoctorPageController extends GetxController {
  var doctorDetail = Rxn<Map<String, dynamic>>();
  final _box = GetStorage();
  var userId = ''.obs;
  var packages = <Map<String, dynamic>>[].obs;

  void fetchDoctorDetail() async {
    try {
      if (userId.value.isEmpty) {
        print("User ID is empty. Cannot fetch doctor details.");
        return;
      }

      final url =
          'https://bpkbautodigital.com/api/admin/detail-dokter/${userId.value}';
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
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);

        // Check if 'data' exists in the response
        if (decodedBody != null && decodedBody['data'] != null) {
          doctorDetail.value = Map<String, dynamic>.from(decodedBody['data']);
        } else {
          print("Unexpected response format: 'data' not found.");
          doctorDetail.value = {}; // Set an empty map if data is missing
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching doctor details: $e');
    }
  }

  void fetchPackages() async {
    try {
      final url =
          'https://bpkbautodigital.com/api/paket/paket-dokter/${userId.value}';
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
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);

        // Assuming 'data' contains a list of packages
        if (decodedBody != null && decodedBody['data'] != null) {
          packages.value = List<Map<String, dynamic>>.from(decodedBody['data']);
        } else {
          print("Unexpected response format: 'data' not found.");
          packages.clear();
        }
      } else {
        print('Failed to load packages: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching packages: $e');
    }
  }

  void createChat() async {
    try {
      final url = 'https://bpkbautodigital.com/api/chat';
      final accessToken = _box.read('access_token');

      if (accessToken == null) {
        print("Access token is missing. Please log in again.");
        return;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'user_id': userId.value, 
        }),
      );

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final userId = decodedBody['id'];
        Get.toNamed(Routes.PESAN_PAGE, arguments: {'user_id': userId});
      } else {
        print('Failed to create chat: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error creating chat: $e');
    }
  }

  @override
  void onInit() {
    userId.value = Get.arguments['id']?.toString() ?? '';
    print('User ID: ${userId.value}');
    fetchDoctorDetail();
    fetchPackages();
    super.onInit();
  }
}
