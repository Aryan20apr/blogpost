import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class UserProvider extends ChangeNotifier
{
    String _firstname = '';
    String _lastname = '';
    String _username = '';
    String _email = '';
    String? _imagename;
    String? imageUrl;
 String? get getImageUrl => this.imageUrl;

  late FirebaseMessaging messaging;

  UserProvider.initialize(SharedPreferences prefs) 
  {
    messaging = FirebaseMessaging.instance;
      saveDeviceFCMToken(prefs);
  }
  Future<void> saveDeviceFCMToken(SharedPreferences prefs) async {
    try {
      String? token = await messaging.getToken();
      log('Token obtained: $token');
      prefs.setString(Constants.FCM_TOKEN, token!);
    } catch (err) {
      log('error when obtaining fcm token ${err.toString()}');
    }
  }

 set setImageUrl(String? imageUrl) => this.imageUrl = imageUrl;
    String _about='';
    int _id = 0;
    // int _userRoleId = 0;
    // String _roleName = '';
    // int _roleId = 0;
    LoadingStatus _isloading=LoadingStatus.loading;
    String _token='';
    bool isInitialized=false;
    XFile? _imagefile=null;
    
    LoadingStatus get isloading => _isloading;
String get token => _token;
 set isloading(LoadingStatus value) {
    _isloading = value;
  }
  set token(String value) {
    _token = value;
  }

  bool _enabled=true;

  String get firstname => _firstname;

  set firstname(String value) {
    _firstname = value;
  }

  String get lastname => _lastname;

  set lastname(String valueString) {
    _lastname = valueString;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

   String get about => _about;

  set about(String value) {
    _about = value;
  }


  int get id => _id;

  set id(int value) {
    _id = value;
  }
 String? get imagename => _imagename;

  set imagename(String? value) {
    _imagename = value;
  }
  XFile? get imagefile => _imagefile;

  set imagefile(XFile? value) {
    _imagefile = value;
  }

  // int get userRoleId => _userRoleId;

  // set userRoleId(int value) {
  //   _userRoleId = value;
  // }

  // String get roleName => _roleName;

  // set roleName(String value) {
  //   _roleName = value;
  // }

  // int get roleId => _roleId;

  // set roleId(int value) {
  //   _roleId = value;
  // }

  void updateUser({required String about,required String firstName,required String lastName} )
  {
    _about=about;
    _firstname=firstName;
    _lastname=lastName;
    notifyListeners();
  }

  bool get enabled => _enabled;

  set enabled(bool value) {
    _enabled = value;
  }

  void updateLoadingStatus(LoadingStatus loadingStatus)
  {
    this.isloading=loadingStatus;
    notifyListeners();
  }

   void updateImage(XFile? file)
  {
    _imagefile=file;
    notifyListeners();
  }

  void updateInitialization()
  {
    log("Initialization status changed");
    this.isInitialized=!this.isInitialized;
    log("Initialization Condition $isInitialized");
    notifyListeners();
  }
  
  
}