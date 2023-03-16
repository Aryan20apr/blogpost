import 'dart:developer';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class FCMService {
  
/// Initialize the [FlutterLocalNotificationsPlugin] package.
 FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;


void configureNotifications()async
{
  // Set the background messaging handler early on, as a named top-level function. No Need of this method, as automatically habdled by android system.
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log('new notificaiton: ${message.data}');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android!;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
             //channelDescription: channel.description,
              icon: android.smallIcon,
              //icon: 'launch_background',
              // other properties...
            ),
          ));
    }
  });

}

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}



bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
         channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );
  }
}

 

}
