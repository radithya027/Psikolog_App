import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/theme/theme.dart';

class DefaultAppbar extends StatelessWidget {
  const DefaultAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.background,
      title: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widthScreen * 0.02,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: widthScreen * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Davin Kafila Didar',
                  style: AppTextStyle.tsTitleBold(AppColor.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
