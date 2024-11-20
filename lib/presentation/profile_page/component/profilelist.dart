import 'package:flutter/material.dart';
import '../../../infrastructure/theme/theme.dart';

class ProfileList extends StatelessWidget {
  final String title;
  final String? description;

  const ProfileList({
    super.key,
    required this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(0.1),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.tsSmallRegular(AppColor.black),
          ),
          SizedBox(height: 4),
          Text(
            description ?? "Data User",
            style: AppTextStyle.tsBodyBold(AppColor.black),
            maxLines: null,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}