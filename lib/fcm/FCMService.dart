import 'dart:developer';
import 'dart:io';

import 'package:blogpost/screens/WelcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../screens/Content/Post/MessagePost.dart';
import 'ForeGroundNotificationService.dart';



class FCMService {
  
/// Initialize the [FlutterLocalNotificationsPlugin] package.
 static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;//=FlutterLocalNotificationsPlugin();
/// Create a [AndroidNotificationChannel] for heads up notifications
static late  AndroidNotificationChannel channel;
/// Initialize the [FlutterLocalNotificationsPlugin] package.
//late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

static bool isFlutterLocalNotificationsInitialized = false;
//  =
// FlutterLocalNotificationsPlugin();

//background handler works in its own isolate, and not part of
//the application therefore, we should keep it out of any context, outside the
//flutter application
@pragma('vm:entry-point')
static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  // showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  log('background message: ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications




static Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // /// Update the iOS foreground notification presentation options to allow
  // /// heads up notifications.
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  isFlutterLocalNotificationsInitialized = true;
}

// static void configureNotifications()async
// {
//   // Set the background messaging handler early on, as a named top-level function. No Need of this method, as automatically habdled by android system.
//   //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
//   if (!kIsWeb) {
//     await setupFlutterNotifications();
//   }
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     log('new notificaiton: ${message.data}');
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android!;

//     // If `onMessage` is triggered with a notification, construct our own
//     // local notification to show to users using the created channel.
//     if (notification != null && android != null) {
//       flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//              //channelDescription: channel.description,
//               icon: android.smallIcon,
//               //icon: 'launch_background',
//               // other properties...
//             ),
//           ));
//     }
//   });

// }

// static Future<void>  _messageHandler(RemoteMessage message) async {
//   print('background message ${message.notification!.body}');
// }

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   await setupFlutterNotifications();
//   showFlutterNotification(message);
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   print('Handling a background message ${message.messageId}');
// }



// static bool isFlutterLocalNotificationsInitialized = false;

// static Future<void> setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     return;
//   }
//   channel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description: 'This channel is used for important notifications.', // description
//     importance: Importance.high,
//   );

  

//   /// Create an Android Notification Channel.
//   ///
//   /// We use this channel in the `AndroidManifest.xml` file to override the
//   /// default FCM channel to enable heads up notifications.
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   /// Update the iOS foreground notification presentation options to allow
//   /// heads up notifications.
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   isFlutterLocalNotificationsInitialized = true;
// }

// void showFlutterNotification(RemoteMessage message) {
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   if (notification != null && android != null && !kIsWeb) {
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//          channelDescription: channel.description,
//           icon: 'launch_background',
//         ),
//       ),
//     );
//   }
// }



  static void configureForegroundMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationService.display(message);
    });
  }

  static void handleMessageClickEvent(bool isLoggedIn) async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      goToArticleScreen(initialMessage.data,isLoggedIn);
    }

    //if the app is in background (not terminated), but open and user taps on
    //on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      //message.data has key-value pairs
      //we can put a route key to tell which screen to navigate to
      //using named route
      log('app in background: message tapped: ${message.data}');
      //Navigate to the screen
      goToArticleScreen(message.data,isLoggedIn);
    });
  }

  static void goToArticleScreen(Map<String, dynamic> messageData,bool loggedIn) {
    if (loggedIn == true) {
      Get.to(() => MessageArticlePage(data: messageData));
    } else {
      Get.to(() =>  WelcomeScreen());
    }
  }

}
