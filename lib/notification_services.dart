
import 'dart:io';
import 'dart:math';

import 'package:cafe_admin/page/settings_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async{
  print('Title: ${message.notification?.title}');
  print('Title: ${message.notification?.body}');
  print('Payload: ${message.data}');
}
class NotificationServices {
  final BuildContext context;
  NotificationServices(this.context);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // final FlutterLocalNotificationsPlugin
  // flutterLocalNotificationsPlugin
  // = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    Navigator.pushNamed(context, SettingsPage.routeName, arguments: message);
  }

  Future initPUshNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage()
        .then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotifications() async {
    await messaging.requestPermission();
    final fcmToken = await messaging.getToken();
    print('Token : $fcmToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}


  // void requestNotificationPermission() async{
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: true,
  //     badge: true,
  //     carPlay: true,
  //     criticalAlert: true,
  //     provisional: true,
  //     sound: true,
  //   );
  //
  //   if(settings.authorizationStatus == AuthorizationStatus.authorized){
  //     print('user granted permission');
  //   }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
  //     print('user granted provision permission');
  //   }else{
  //
  //   }
  // }
  //
  // void initLocalNotifications(BuildContext context,RemoteMessage message) async{
  //   var androidInitialization = AndroidInitializationSettings('android/app/src/main/res/mipmap-mdpi/ic_launcher.png');
  //   var initializationSettings = InitializationSettings(
  //     android: androidInitialization,
  //   );
  //
  //   await flutterLocalNotificationsPlugin.initialize(
  //       initializationSettings,
  //     onDidReceiveNotificationResponse: (payload){
  //
  //     }
  //   );
  // }
  //
  // void firebaseInit(BuildContext context){
  //   FirebaseMessaging.onMessage.listen((message) {
  //     if(Platform.isAndroid){
  //       initLocalNotifications(context, message);
  //       showNotification(message);
  //     }
  //   });
  // }
  //
  // Future<void> showNotification(RemoteMessage message) async{
  //
  //   AndroidNotificationChannel channel =
  //   AndroidNotificationChannel(
  //       Random.secure().nextInt(100000).toString(),
  //       'High Importance Notifications',
  //       importance: Importance.max
  //       );
  //
  //   AndroidNotificationDetails androidNotificationDetails =
  //   AndroidNotificationDetails(
  //       channel.id.toString(),
  //       channel.name.toString(),
  //       channelDescription: 'Your channel description',
  //       importance: Importance.high,
  //       priority: Priority.high,
  //       ticker: 'ticker'
  //       );
  //   NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //   );
  //
  //
  //   Future.delayed(Duration.zero,(){
  //     flutterLocalNotificationsPlugin.show(
  //         0,
  //         message.notification!.title.toString(),
  //         message.notification!.body.toString(),
  //         notificationDetails);
  //
  //   });
  //
  // }

  // Future<String> getDeviceToken() async{
  //   String? token = await messaging.getToken();
  //   return token!;
  // }
  //
  // void isTokenRefresh()async{
  //   messaging.onTokenRefresh.listen((event) {
  //     event.toString();
  //   });
  // }

