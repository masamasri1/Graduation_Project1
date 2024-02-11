import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings(
          'app_icon'), // Replace with your app icon
      iOS: IOSInitializationSettings(),
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  static Future<void> showNotificationWithActions(
      String messageText, String buttonText) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      'channel_description',
      importance: Importance.max,
      priority: Priority.high,
      channelShowBadge: true,
      playSound: true,
      enableVibration: true,
      styleInformation: DefaultStyleInformation(true, true),
      ticker: 'ticker',
    );

    final IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      'Notification Title',
      messageText,
      platformChannelSpecifics,
      payload: buttonText,
    );
  }

  static Future<void> onSelectNotification(String? payload) async {
    if (payload == 'Accept') {
      // Handle accept action
      navigateToRecommendationPage();
    } else if (payload == 'Block') {
      // Handle block action
      print('Notification blocked');
    }
  }

  static void navigateToRecommendationPage() {
    // Implement navigation logic to the recommendation page.
    // You can use Navigator to push a new page onto the stack.
    // For example:
    // Navigator.push(context, MaterialPageRoute(builder: (context) => RecommendationPage()));
  }
}

void showNotificationWithActions(String messageText, String buttonText) {
  // Show a notification with accept and block actions
  NotificationHelper.showNotificationWithActions(messageText, buttonText);
}
