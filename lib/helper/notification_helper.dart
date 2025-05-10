import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
<<<<<<< HEAD
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
=======
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
>>>>>>> master
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../main.dart';

class NotificationHelper{
<<<<<<< HEAD
  static Future<void> initialize(FlutterLocalNotificationsPlugin notificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    notificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload){
=======
  /*
  static Future<void> initialize(FlutterLocalNotificationsPlugin notificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    //var iOSInitialize = const IOSInitializationSettings();
    //var initializationSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    /*notificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload){
>>>>>>> master
      try{
        if(payload != null && payload.isNotEmpty){

        } else {

        }
      }catch(e){
        if(kDebugMode){
          print(e.toString());
        }
      }

      return;
<<<<<<< HEAD
    });
=======
    });*/
>>>>>>> master

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin);
      if(Get.find<AuthController>().userLoggedIn()){

      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      try{
        if(message.notification?.titleLocKey != null){

        } else {

        }
      } catch (e){
        print(e.toString());
      }
    });
  }

  static Future<void> showNotification(RemoteMessage msg, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      msg.notification!.body!, htmlFormatBigText: true,
      contentTitle: msg.notification!.title!, htmlFormatContentTitle: true
    );

    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id_1',
      'dbfood 2',
      importance: Importance.high,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      playSound: true
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
<<<<<<< HEAD
      iOS: const IOSNotificationDetails(),
=======
      //iOS: const IOSNotificationDetails(),
>>>>>>> master
    );

    await fln.show(0, msg.notification!.title, msg.notification!.body, platformChannelSpecifics);
  }
<<<<<<< HEAD
=======

  */
>>>>>>> master
}