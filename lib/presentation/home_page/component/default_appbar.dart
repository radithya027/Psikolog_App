import 'package:flutter/material.dart';
import '../../../infrastructure/theme/theme.dart';

class DefaultAppbar extends StatelessWidget {
  final String name;

  const DefaultAppbar({
    Key? key,
    required this.name, // Accept name as a parameter
  }) : super(key: key);

  // Helper function to extract initials
  String getInitials(String name) {
    List<String> nameParts = name.split(" ");
    String initials =
        nameParts.map((part) => part.isNotEmpty ? part[0] : "").join();
    return initials.length > 2
        ? initials.substring(0, 2).toUpperCase()
        : initials.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.background,
      title: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widthScreen * 0.02,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColor.blue500,
              child: Text(
                getInitials(name), // Display initials
                style: AppTextStyle.tsBodyBold(AppColor.white),
              ),
            ),
            SizedBox(width: 8),
            Text(
              name, // Display the dynamic name
              style: AppTextStyle.tsBodyBold(AppColor.black),
            ),
          ],
        ),
      ),
    );
  }
}
