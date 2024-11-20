import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class HomePageController extends GetxController {
  RxString name = ''.obs;
  var bannerList = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var userList = <Map<String, dynamic>>[].obs;
  var bookList = <Map<String, dynamic>>[].obs;
  final _box = GetStorage();
  var artikelList = <Map<String, dynamic>>[].obs;
  var realtimeDoctorList = <Map<String, dynamic>>[].obs;
  var selectedFilter = '3day'.obs;
  var filteredDoctorList = <Map<String, dynamic>>[].obs;
  var allDoctorList = <Map<String, dynamic>>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchRealtimeDoctors();
    fetchAllDoctors();
    fetchBookList();
    fetchUserProfile();
    fetchArtikelList();
    fetchBannerList();
  }

  void updateFilter(String value) async {
    selectedFilter.value = value;
    if (value == 'filter') {
      filteredDoctorList.value = fetchAllDoctors() as List<Map<String, dynamic>>;
    } else {
      // Otherwise, fetch filtered doctors
      await fetchFilteredDoctors(value);
    }
  }

  Future<void> fetchFilteredDoctors(String type) async {
    try {
      final url =
          'https://bpkbautodigital.com/api/paket/get-paketype?type=$type';
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
          print("Fetched filtered doctors: $filteredDoctorList");
        } else {
          print('Data retrieval failed: ${jsonResponse['message']}');
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchAllDoctors() async {
    try {
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
        // Initially set filteredDoctorList to show all doctors
        filteredDoctorList.value = allDoctorList;
      } else {
        print('Failed to load doctors: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void fetchBookList() async {
    try {
      final url = 'https://bpkbautodigital.com/api/book/all';
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
        if (jsonResponse['success'] == true) {
          bookList.value =
              List<Map<String, dynamic>>.from(jsonResponse['data']);
          print("Fetched books: $bookList"); // Debug output
        } else {
          print('Data retrieval failed');
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    final url = Uri.parse('https://bpkbautodigital.com/api/auth/user-detail');
    final accessToken = _box.read('access_token');

    if (accessToken == null) {
      Get.snackbar("Error", "Token tidak ditemukan.");
      isLoading.value = false;
      return;
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("API Response: $data");
        if (data.containsKey('user') && data['user'].containsKey('name')) {
          name.value = data['user']['name'];
        } else {
          name.value = 'Nama tidak tersedia';
          print("Name key not found in the response.");
        }
      } else {
        print("Status code: ${response.statusCode}");
        print("Response: ${response.body}");
        Get.snackbar("Error", "Gagal mengambil profil pengguna.");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan saat mengambil profil.");
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void fetchArtikelList() async {
    try {
      final url = 'https://bpkbautodigital.com/api/artikel/all-artikel';
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

        if (jsonResponse['status'] == 'success' &&
            jsonResponse['data'] != null) {
          artikelList.value =
              List<Map<String, dynamic>>.from(jsonResponse['data']);
          print(
              "Fetched artikels: $artikelList"); // Debug output to check fetched data
        } else {
          print('Data retrieval failed: ${jsonResponse['message']}');
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void fetchRealtimeDoctors() async {
    try {
      final url =
          'https://bpkbautodigital.com/api/paket/get-paketype?type=realtime';
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
          realtimeDoctorList.value = List<Map<String, dynamic>>.from(
              jsonResponse['data'].map((paket) => paket['user']).toList());
          print("Fetched realtime doctors: $realtimeDoctorList");
        } else {
          print('Data retrieval failed: ${jsonResponse['message']}');
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void fetchBannerList() async {
    try {
      final url = 'https://bpkbautodigital.com/api/banner/all-banner';
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

        if (jsonResponse['message'] == 'List banner' &&
            jsonResponse['data'] != null) {
          bannerList.value =
              List<Map<String, dynamic>>.from(jsonResponse['data']);
        } else {
          print('Data retrieval failed: ${jsonResponse['message']}');
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
