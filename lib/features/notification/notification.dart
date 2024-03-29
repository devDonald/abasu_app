import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_type.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Message ${message.data}');
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            priority: Priority.high,
            importance: Importance.max,
            fullScreenIntent: true,
            timeoutAfter: 10000,
          ),
          iOS: const IOSNotificationDetails()));

  _handleMessage(message);
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications',
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initMessaging() {
  var androiInit = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosInit = const IOSInitializationSettings();
  var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
  var fltNotification = FlutterLocalNotificationsPlugin();
  fltNotification.initialize(initSetting);
  var androidDetails = const AndroidNotificationDetails(
    'high_importance_channel', // id
    'High Importance Notifications', // title// description
    importance: Importance.high,
  );
  var iosDetails = const IOSNotificationDetails();
  var generalNotificationDetails =
      NotificationDetails(android: androidDetails, iOS: iosDetails);

  setupInteractedMessage();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    display(message);
    _handleMessage(message);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    display(message);
    _handleMessage(message);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> setupInteractedMessage() async {
  // Get any messages which caused the application to open from
  // a terminated state.
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  // If the message also contains a data property with a "type" of "chat",
  // navigate to a chat screen
  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }

  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
}

void _handleMessage(RemoteMessage message) {
  if (message.data['type'] == NotificationType.newRequest) {
    //Get.to(() => const GeneralEvents());
  }
  if (message.data['type'] == NotificationType.newContract) {
    //Get.to(() => const YoutubeLive());
  }
  if (message.data['type'] == NotificationType.newOrder) {
    //Get.to(PastorIncomingCall());
  }
}

void display(RemoteMessage message) async {
  try {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    flutterLocalNotificationsPlugin.show(
        id,
        message.data['title'],
        message.data['body'],
        NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              priority: Priority.high,
              importance: Importance.max,
              fullScreenIntent: true,
              timeoutAfter: 10000,
            ),
            iOS: const IOSNotificationDetails()));
  } on Exception catch (e) {
    print(e);
  }
}
