import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:psikolog_app/infrastructure/theme/theme.dart';

class CardArtikel extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String subtitle;

  const CardArtikel({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightScreen * 0.3,
      width: widthScreen * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(0.1),
            offset: Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                imageUrl,
                width: widthScreen,
                height: heightScreen * 0.17,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'lib/infrastructure/assets/placeholder.jpg',
                    width: widthScreen,
                    height: heightScreen * 0.17,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 9.0,
              ),
              child: Text(
                title,
                style: AppTextStyle.tsBodyBold(AppColor.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              subtitle,
              style: AppTextStyle.tsBodyRegular(AppColor.black),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
