import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/detail_article_page.controller.dart';

class DetailArticlePageScreen extends GetView<DetailArticlePageController> {
  const DetailArticlePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Colors.blue),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Berita',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.article.isEmpty) {
          return Center(child: Text('Article not found'));
        } else {
          // Display article details with image at the top
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display the article image at the top
                  if (controller.article['image'] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        controller.article['image'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.image,
                              size: 100, color: Colors.grey);
                        },
                      ),
                    ),
                  SizedBox(height: 16),
                  // Display the article title below the image
                  Text(
                    controller.article['title'] ?? 'No Title',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Display the article subtitle below the title
                  Text(
                    controller.article['subtitle'] ?? 'No Subtitle',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  // Display the article content below the subtitle
                  Text(
                    controller.article['content'] ?? 'No Content Available',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
