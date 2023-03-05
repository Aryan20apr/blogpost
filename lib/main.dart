

import 'dart:developer';

import 'package:blogpost/providers/RefreshProvider.dart';
import 'package:blogpost/providers/ThemeProvider.dart';
import 'package:blogpost/providers/UserProvider.dart';
import 'package:blogpost/screens/Content/Post/CompletePost.dart';
import 'package:blogpost/screens/Content/Post/FeedPost.dart';
import 'package:blogpost/screens/NavPage.dart';
import 'package:blogpost/screens/WelcomeScreen.dart';
import 'package:blogpost/utils/Themes.dart';
import 'package:blogpost/utils/constants.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'Modals/AllPostsModal.dart';
import 'Modals/UserPostsModal.dart';
import 'fcm/FCMService.dart';
import 'fcm/LocalNotificationService.dart';




late SharedPreferences preferences;
bool loggedIn=false;
/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//  =
// FlutterLocalNotificationsPlugin();

//background handler works in its own isolate, and not part of
//the application therefore, we should keep it out of any context, outside the
//flutter application
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  // showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  log('background message: ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
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



void main()async {

  
   WidgetsFlutterBinding.ensureInitialized();
  //await FirebaseService.initializeFirebase();
await Firebase.initializeApp();
   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  preferences=await SharedPreferences.getInstance();

  if(preferences.containsKey(Constants.LOGIN_STATUS)&&preferences.getBool(Constants.LOGIN_STATUS)==true)
  {
    loggedIn=true;}
  runApp(
  
  DevicePreview(
    enabled: false,//!kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),
);
}

class MyApp extends StatefulWidget {
   MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
  //For controlling theme
  static _MyAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>();
  }
}


class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      themeMode = themeMode;
    });
  }
 _configureForegroundMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      log("Foreground message:${message.messageId}");
      LocalNotificationService.display(message);
    });
  }

  _handleMessageClickEvent() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _goToArticleScreen(initialMessage.data);
    }

    //if the app is in background (not terminated), but open and user taps on
    //on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      //message.data has key-value pairs
      //we can put a route key to tell which screen to navigate to
      //using named route
      log('app in background: message tapped: ${message.data}');
      //Navigate to the screen
      _goToArticleScreen(message.data);
    });
  }

  void _goToArticleScreen(Map<String, dynamic> data) {
    log('===DATE===: ${data['addDate']}');
   Content post=Content(postId: data['postId'],title: data['title'],content: data['content'],imageName:data['imageName'] ,imageUrl:data['imageUrl'],addedDate:data['addedDate'] );
    
    
    if (loggedIn== true) {
      Get.to(
          () => Post(content: post, categoryTitle:data["category"],firstName:data["user"]));
    } else {
      log('user is not logged in');
      // Get.to(() => const LoginPage());
    }
  }
  
@override
void initState()
{
  super.initState();
  LocalNotificationService.initialize(
        context, preferences); 

    _configureForegroundMessaging();
    _handleMessageClickEvent();
}
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return MultiProvider(
         providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider.initialize(preferences)),
              ChangeNotifierProvider<ThemeProvider>(
              create: (context) => ThemeProvider()),
              ChangeNotifierProvider<RefreshProvider>(
              create: (context) => RefreshProvider())
        ],
        child: GetMaterialApp(
          
        debugShowCheckedModeBanner: false,
        //themeMode: themeMode,
        theme: LIGHT_THEME_DATA,
        darkTheme: DARK_THEME_DATA,
        home: loggedIn?NavPage():WelcomeScreen(),
          ),
      );
    }));
  }
}
