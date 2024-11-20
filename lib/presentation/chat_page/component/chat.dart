import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:psikolog_app/infrastructure/theme/theme.dart';

final customTheme = DefaultChatTheme(
    inputBackgroundColor: Colors.blue[50]!,
    inputTextColor: Colors.black,
    primaryColor: AppColor.blue500,
    secondaryColor: Colors.grey[200]!,
    backgroundColor: Colors.white,
    userAvatarNameColors: [Colors.blue, Colors.green],
    receivedMessageBodyTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 14,
    ),
    sentMessageBodyTextStyle: AppTextStyle.tsBodyBold(AppColor.black));
