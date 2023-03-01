

import 'package:blogpost/providers/RefreshProvider.dart';
import 'package:blogpost/providers/ThemeProvider.dart';
import 'package:blogpost/providers/UserProvider.dart';
import 'package:blogpost/screens/NavPage.dart';
import 'package:blogpost/screens/WelcomeScreen.dart';
import 'package:blogpost/utils/Themes.dart';
import 'package:blogpost/utils/constants.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:flutter/material.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'fcm/FCMService.dart';




late SharedPreferences preferences;
bool loggedIn=false;



void main()async {

  
   WidgetsFlutterBinding.ensureInitialized();
  //await FirebaseService.initializeFirebase();
await Firebase.initializeApp();
  

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

  
@override
void initState()
{
  super.initState();
  FCMService().configureNotifications();
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
