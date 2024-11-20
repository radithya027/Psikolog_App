import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../infrastructure/theme/theme.dart';
import 'controllers/chat_page.controller.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatPageScreen extends GetView<ChatPageController> {
  const ChatPageScreen({super.key});

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: AppColor.blue500,
        ),
        title: Text('Chat', style: AppTextStyle.tsTitleBold(AppColor.black)),
      ),
      body: Obx(() {
        return DashChat(
          currentUser: ChatUser(
            id: controller.currentUserId.toString(),
          ),
          messages: controller.formattedMessages,
          onSend: (ChatMessage message) {
            controller.messageText.value = message.text;
            controller.sendMessage();
          },
          messageOptions: MessageOptions(
            currentUserContainerColor: AppColor.blue500,
            containerColor: AppColor.grey,
          ),
          inputOptions: InputOptions(
            inputDecoration: InputDecoration(
              hintText: 'Ketik pesan',
              filled: true,
              fillColor: AppColor.txtfield,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
            ),
            sendButtonBuilder: (void Function() send) {
              return IconButton(
                icon: Icon(IconsaxPlusBold.send_2, color: AppColor.blue500),
                onPressed: send,
              );
            },
          ),
        );
      }),
    );
  }
}
