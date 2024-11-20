import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:dash_chat_2/dash_chat_2.dart';
import 'dart:convert';

class ChatPageController extends GetxController {
  final _box = GetStorage();
  var messages = <Map<String, dynamic>>[].obs;
  var chatId = ''.obs;
  var messageText = ''.obs;
  final currentUserId = 10; // Example current user ID; adjust accordingly

  List<ChatMessage> get formattedMessages {
    return messages.map((message) {
      final userId = message['user_id'];
      return ChatMessage(
        text: message['message'] ?? '',
        createdAt: DateTime.parse(message['created_at']),
        user: ChatUser(
          id: userId.toString(),
          firstName: message['user']['name'],
          profileImage: message['user']['profile_picture'],
        ),
        customProperties: {'isSender': message['is_sender']},
      );
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();

    print('Received arguments: ${Get.arguments}');
    chatId.value = Get.arguments?['id']?.toString() ?? '';

    print('chat id : ${chatId.value}');
    fetchChatMessages();
  }

  void fetchChatMessages() async {
    try {
      final url =
          'https://bpkbautodigital.com/api/chat_message?chat_id=${chatId.value}';
      final accessToken = _box.read('access_token');

      if (accessToken == null) {
        print("Access token is missing. Please log in again.");
        return;
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        if (decodedBody['status'] == 'success' && decodedBody['data'] != null) {
          // Ubah daftar pesan menjadi dari terbaru ke terlama
          final List<Map<String, dynamic>> fetchedMessages =
              List<Map<String, dynamic>>.from(
            decodedBody['data'].map((message) => {
                  'chat_id': message['chat_id'],
                  'message': message['message'] ?? 'Pesan kosong',
                  'user_id': message['user_id'],
                  'created_at': message['created_at'],
                  'is_sender': message['user_id'] == currentUserId,
                  'user': {
                    'name': message['user']['name'],
                    'profile_picture': message['user']['profile_picture'],
                  },
                }),
          );

          fetchedMessages.sort((a, b) {
            return DateTime.parse(b['created_at'])
                .compareTo(DateTime.parse(a['created_at']));
          });

          messages.value = fetchedMessages;
        } else {
          print("Unexpected status or missing data in response.");
        }
      } else {
        print('Failed to fetch messages: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  void sendMessage() async {
    if (messageText.value.isEmpty) return;

    try {
      final url = 'https://bpkbautodigital.com/api/chat_message';
      final accessToken = _box.read('access_token');

      if (accessToken == null) {
        print("Access token is missing. Please log in again.");
        return;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'chat_id': chatId.value,
          'message': messageText.value,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Message sent successfully');

        final responseBody = json.decode(response.body);
        if (responseBody['data'] != null) {
          final sentMessage = responseBody['data'];
          messages.insert(0, {
            'chat_id': sentMessage['chat_id'],
            'message': sentMessage['message'],
            'user_id': sentMessage['user_id'],
            'created_at': sentMessage['created_at'],
            'is_sender': sentMessage['user_id'] == currentUserId,
            'user': {
              'name': sentMessage['user']['name'],
              'profile_picture': sentMessage['user']['profile_picture'],
            },
          });
        } else {
          print("No data field in response after sending message.");
        }

        messageText.value = '';
      } else {
        print('Failed to send message: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}
