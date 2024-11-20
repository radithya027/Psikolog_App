import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailArticlePageController extends GetxController {
  var article = {}.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    final articleId = Get.arguments;
    fetchArticleDetails(articleId);
  }
  Future<void> fetchArticleDetails(int id) async {
    final id = Get.arguments;
    try {
      final response = await http.get(Uri.parse(
          'https://bpkbautodigital.com/api/artikel/show-artikel/$id'));
      if (response.statusCode == 200) {
        article.value = json.decode(response.body)['data'];
      } else {
        print(response.statusCode);
        print("Failed to load article details");
      }
    } catch (e) {
      print("Error fetching article: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
