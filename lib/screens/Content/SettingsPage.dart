import 'dart:io';
import 'dart:ui';

import 'package:blogpost/screens/WelcomeScreen.dart';
import 'package:blogpost/screens/settings/PasswordChange.dart';
import 'package:blogpost/screens/settings/UpdateAccount.dart';
import 'package:blogpost/utils/colors.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';
import '../../providers/UserProvider.dart';
import '../settings/PasswordUpdate.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with AutomaticKeepAliveClientMixin{
 //bool _value = false;

 //bool _useSystemSettings = true;
 
  
  @override
  Widget build(BuildContext context) {
    UserProvider provider=Provider.of<UserProvider>(context);
   var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
    return SafeArea(child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text('Settings')),
      body:  SettingsList(
        darkTheme: SettingsThemeData(),
      sections: [
        CustomSettingsSection(child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
                  decoration: BoxDecoration(color: isDarkMode?Colors.black12:Colors.white/*Colors.greenAccent.shade100*/,borderRadius: BorderRadius.circular(20)),
                  height: 18.h,
                  width: 80.w,
                  child: LayoutBuilder(
                    builder: (context,userDetailConstraint) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [ Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: CircleAvatar(
                              radius: userDetailConstraint.maxWidth*0.1,
                              backgroundColor: Colors.grey ,
                              child: ClipOval(
                        child: new SizedBox(
                          width: userDetailConstraint.maxWidth*0.2,
                          height: userDetailConstraint.maxWidth*0.2,
                          child: (provider.imagefile!=null)?Image.file(
                          provider.imagefile! as File,// File(provider.imagefile!.path),
                            fit: BoxFit.fill,
                          ):Image.network(
                            "https://updowndemo.blob.core.windows.net/blob-demo-container/image_picker57520513599466492.jpg?si=Client%20Read&spr=https&sv=2021-06-08&sr=c&sig=Ph0eekL09Jv82offqeob14Lyhg7oZNI611YPmKjsx5g%3D",
                            fit: BoxFit.fill,
                          ),
                        )),
                            ),
                          ),
                          
                          Expanded
                          (
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                
                                children: [
                                  Text('${provider.firstname} ${provider.lastname}',style: GoogleFonts.sourceSansPro(color: isDarkMode?infotextColorDark:infotextColorLight,fontSize: 18.sp),),
                                  Text('Email: ${provider.email}',softWrap: true,style: GoogleFonts.sourceSansPro(color: isDarkMode?infotextColorDark:infotextColorLight,fontSize: 12.sp),),
                                  
                                  
                                ],
                              ),
                            ),
                          ),
                         
        
                        ],
                      );
                    }
                  ),
                ),
        )),
        SettingsSection(
          title: Text('Account Settings'),
          tiles: <SettingsTile>[
            
            SettingsTile.navigation(
              leading: Icon(EvaIcons.personOutline),
              title: Text('Update Profile'),
              onPressed: (context) {
                Get.to(()=>AccountSettings());
              },
            ),
             SettingsTile.navigation(
              leading: Icon(Icons.password_rounded),
              title: Text('Change Password'),
              onPressed: (context) {
                Get.to(()=>UpdatePassword());
              },
            ),
           
          ],
        ),
         SettingsSection(title: Text('App Settings'),tiles: <SettingsTile>[/*SettingsTile.switchTile(
          initialValue:_useSystemSettings,
              onToggle: (value) {
                 setState(() {
              _useSystemSettings= value;
              
              if (_useSystemSettings)
                MyApp.of(context)!.changeTheme(ThemeMode.system);
              else
              {
                 if (_value)
                MyApp.of(context)!.changeTheme(ThemeMode.dark);
              else
                MyApp.of(context)!.changeTheme(ThemeMode.light);
              }
            });
              },
              
              leading: Icon(Icons.format_paint),
              title: Text('Use System Theme'),
            ), SettingsTile.switchTile(
              enabled: _useSystemSettings==false,
          initialValue:_value,
              onToggle: (value) {
                 setState(() {
              _value = value;
              if (_value)
                MyApp.of(context)!.changeTheme(ThemeMode.dark);
              else
                MyApp.of(context)!.changeTheme(ThemeMode.light);
            });
              },
              
              leading: Icon(Icons.format_paint),
              title: Text('Dark Mode'),
            ),*/
            SettingsTile.navigation(
              leading: Icon(FontAwesomeIcons.arrowRightFromBracket),
              title: Text('Logout'),
              onPressed: (context) {

                Get.offAll(()=>WelcomeScreen());
              },
            ),])
      ],
    ),
    ));
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}