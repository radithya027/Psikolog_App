import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class DokterharianPageController extends GetxController {
  final isLoading = false.obs;
  final filteredDoctorList = <Map<String, dynamic>>[].obs;
  final allDoctorList = <Map<String, dynamic>>[].obs;
  final selectedFilter = 'Semua'.obs;
  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchAllDoctors();
  }

  void updateFilter(String value) async {
    selectedFilter.value = value;
    if (value == 'Semua') {
      await fetchAllDoctors();
    } else {
      await fetchFilteredDoctors(value);
    }
  }

  Future<void> fetchAllDoctors() async {
    try {
      isLoading.value = true;
      final url = 'https://bpkbautodigital.com/api/accessall/all-doctor';
      final accessToken = _box.read('access_token');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        allDoctorList.value = List<Map<String, dynamic>>.from(jsonResponse);
      } else {
        print('Failed to load doctors: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFilteredDoctors(String type) async {
    try {
      isLoading.value = true;
      final url = 'https://bpkbautodigital.com/api/paket/get-paketype?type=$type';
      final accessToken = _box.read('access_token');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['message'] == 'List of pakets by type' &&
            jsonResponse['data'] != null) {
          filteredDoctorList.value = List<Map<String, dynamic>>.from(
              jsonResponse['data'].map((paket) => paket['user']).toList());
        } else {
          print('Data retrieval failed: ${jsonResponse['message']}');
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}