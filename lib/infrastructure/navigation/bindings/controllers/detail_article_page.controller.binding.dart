import 'package:get/get.dart';

import '../../../../presentation/detail_article_page/controllers/detail_article_page.controller.dart';

class DetailArticlePageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailArticlePageController>(
      () => DetailArticlePageController(),
    );
  }
}
