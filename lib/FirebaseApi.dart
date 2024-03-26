import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    print("Here");
    await _firebaseMessaging.requestPermission();
    final FCMToken = await _firebaseMessaging.getToken();
    print("Token: $FCMToken");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotifications();
    //await FirebaseMessaging.instance.setAutoInitEnabled(true);
  }
}

Future initPushNotifications() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );


  //FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
}



Future<void> handleBackgroundMessage (RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload:${message.data}');
}