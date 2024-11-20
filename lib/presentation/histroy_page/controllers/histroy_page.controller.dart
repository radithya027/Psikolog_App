import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:psikolog_app/presentation/histroy_page/model/historyModel.dart';

class HistroyPageController extends GetxController with StateMixin<List<HistoryItem>> {
  final _box = GetStorage();
  final historyList = <HistoryItem>[].obs;
  final selectedFilter = 'semua'.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHistoryData();
  }

  void updateFilter(String filter) {
    selectedFilter.value = filter;
    fetchHistoryData();
  }

  Future<void> fetchHistoryData() async {
    isLoading.value = true;
    try {
      final accessToken = _box.read('access_token');
      String url = 'https://bpkbautodigital.com/api/payment/history';
      
      // Add type parameter if not 'semua'
      if (selectedFilter.value != 'semua') {
        url += '?type=${selectedFilter.value}';
      }

      final response = await GetConnect().get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 && response.body['success'] == true) {
        List<HistoryItem> loadedHistory = (response.body['data'] as List)
            .map((data) => HistoryItem.fromJson(data))
            .toList();
        historyList.assignAll(loadedHistory);
        change(historyList, status: RxStatus.success());
      } else {
        print("Failed to fetch data - Status Code: ${response.statusCode}");
        change(null, status: RxStatus.error('Failed to fetch history data'));
      }
    } catch (e) {
      print("Error: $e");
      change(null, status: RxStatus.error('Error: $e'));
    } finally {
      isLoading.value = false;
    }
  }
}