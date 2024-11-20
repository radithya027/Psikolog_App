
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:psikolog_app/presentation/firebase/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  static final channel =  AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Channel',
    importance: Importance.high,
  );

  static final flutterNotificationPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initLocalNotifications() async {
    final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    await flutterNotificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        handleNotificationClick(response.payload);
      },
    );

    await flutterNotificationPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  }

  static void handleNotificationClick(String? payload) async {
    if (payload != null) {
      final RegExp regExp = RegExp(r'order id (\d+)');
      final match = regExp.firstMatch(payload.toLowerCase());
     }
  }

  static Future<void> handleMessage(RemoteMessage message) async {
    if (message.notification != null) {
      RemoteNotification notification = message.notification!;
      flutterNotificationPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: message.notification?.body,
      );
    }
  }

  static Future<void> handleBackgroundMessaging(RemoteMessage message) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    if (message.notification != null) {
      flutterNotificationPlugin.show(
        message.notification.hashCode,
        message.notification?.title,
        message.notification?.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: message.notification?.body,
      );
    }
  }

  Future<void> initNotifications() async {
    try {
      NotificationSettings settings = await firebaseMessaging.requestPermission(
        alert: true,
        sound: true,
        badge: true,
        provisional: false,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
              } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {

      } else {
        return; // Exit if permission not granted
      }

      // Listen for foreground messages
      FirebaseMessaging.onMessage.listen(FirebaseApi.handleMessage);

      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(FirebaseApi.handleBackgroundMessaging);

      // Initialize local notifications
      await FirebaseApi.initLocalNotifications();
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }
}
