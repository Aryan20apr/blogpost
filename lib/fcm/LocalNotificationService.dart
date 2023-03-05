import 'dart:developer';

import 'package:blogpost/screens/settings/PasswordChange.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Modals/AllPostsModal.dart';
import '../screens/Content/Post/CompletePost.dart';
import '../screens/Content/Post/FeedPost.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();

  static late Map<String, dynamic> _data;
  static void initialize(
      BuildContext context, SharedPreferences sharedPreferences) {
    final InitializationSettings initializationSettings =
        const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    // _notificationPlugin.initialize(initializationSettings,onSelectNotification: (String? payload)async{

    //   //route to a screen
    // });
    _notificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        log('Foreground notification clicked: response type: ${notificationResponse.notificationResponseType}');
        log('===DATE===: ${_data['addDate']}');
       Content post=Content(postId: _data['postId'],title: _data['title'],content: _data['content'],imageName:_data['imageName'] ,imageUrl:_data['imageUrl'],addedDate:_data['addedDate'] );
        Get.to(() =>Post(content: post, categoryTitle:_data["category"],firstName:_data["user"]));
            //ViewArticle(post: post, sharedPreferences: sharedPreferences));
        // switch (notificationResponse.notificationResponseType) {
        //   case NotificationResponseType.selectedNotification:
        //     // selectNotificationStream.add(notificationResponse.payload);
        //     break;
        //   case NotificationResponseType.selectedNotificationAction:
        //     // if (notificationResponse.actionId == navigationActionId) {
        //     //   // selectNotificationStream.add(notificationResponse.payload);
        //     // }
        //     break;
        // }
      },
    );
  }

//for foreground app notifications (heads-up notifications)
  static void display(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    log('foreground app: message: ${message.data}');
    if (notification != null && android != null && !kIsWeb) {
      try {
        log('Notification hashcode: ${notification.hashCode} and notification title: ${notification.title} and notification body: ${notification.body}');

        final id = DateTime.now().millisecondsSinceEpoch ~/
            1000; //id for the notification, must be unique (milliseconds divided by 1000)
        // final notificationDetails = NotificationDetails(
        //   android: AndroidNotificationDetails(
        //     channel.id,
        //     channel.name,
        //     icon: 'mipmap/ic_launcher',
        //     playSound: true,
        //     enableVibration: true,
        //   ),
        // );
        //this will also create channel
        const notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel', // id
            'High Importance Notifications', // title
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            playSound: true,
            enableVibration: true,
            enableLights: true,
            // actions: [
            //   AndroidNotificationAction(
            //     'nav-id',
            //     'View Article',
            //     showsUserInterface: true,
            //     // By default, Android plugin will dismiss the notification when the
            //     // user tapped on a action (this mimics the behavior on iOS).
            //     cancelNotification: true,
            //   ),
            // ],
          ),
        );

        _data = message.data;
        //now show the notification
        await _notificationPlugin.show(
          id, //or can use notification.hashCode,
          notification.title,
          notification.body,
          notificationDetails,
        );
        //specify payload: message.data['route']
        //to navigate to a screen which is handled by onSelectNotification in _notificationPlugin.initialize()
      } on Exception catch (e) {
        log('FCMNotificationUtil.dart: display() Error occured while showing notification $e');
      }
    }
  }
}