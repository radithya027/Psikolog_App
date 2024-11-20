import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../infrastructure/theme/theme.dart';

class ProfilePicture extends StatelessWidget {
  final String username; // New parameter to accept username

  const ProfilePicture({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Profile picture container
        CircleAvatar(
          radius: 60,
          backgroundColor: AppColor.blue500,
          child: Text(
            getInitials(username), 
            style: AppTextStyle.tsBigTitleBold(AppColor.white),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              print("Image picker tapped");
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.blue500,
                border: Border.all(color: AppColor.white, width: 1),
              ),
              child: Icon(
                IconsaxPlusBold.camera,
                size: 20,
                color: AppColor.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
  String getInitials(String name) {
    List<String> nameParts = name.split(' ');
    if (nameParts.length == 1) {
      return nameParts[0].substring(0, 2).toUpperCase();
    } else {
      return (nameParts[0][0] + nameParts[1][0]).toUpperCase();
    }
  }
}
