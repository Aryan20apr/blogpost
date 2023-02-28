import 'package:blogpost/Modals/loginmodal.dart';
import 'package:blogpost/Modals/registrationmodal.dart';
import 'package:blogpost/screens/Content/HomeScreen.dart';
import 'package:blogpost/screens/NavPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../providers/UserProvider.dart';
import '../utils/Themes.dart';
import '../utils/api.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/neumorphic_stuffs.dart';
import 'EmailVerification.dart';
import 'ForgotPassword.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
 final _formKey = GlobalKey<FormState>();

  late TextEditingController emailController;

  late TextEditingController passwordController;

  @override
  void initState()
  {
    super.initState();
    emailController=TextEditingController();
    passwordController=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
    return SafeArea(child: Scaffold(resizeToAvoidBottomInset: false,backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
    body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:LayoutBuilder(builder: (context,constraints){
        return Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Container(
                                decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(20)),
                                // constraints: BoxConstraints(maxHeight: constraints.maxHeight*0.8 ),
                                width: constraints.maxWidth*0.95,
                                child:Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Form(
                                    key: _formKey,
                                    child: LayoutBuilder(
                                        builder: (context,constraint) {
                                          return Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset("assets/login.jpg",height: 30.h,),
                                              SizedBox(height: 3.h,),
                                              Text("Enter your registered email id and password:",style: TextStyle(color: textFieldColor,fontSize: 12.sp),),
                                              SizedBox(height: 2.h,),
                                              Neumorphic(
                                                style: NeumorphicStuffs().getTextFieldStyle(),
                                                child: TextFormField(
                                                  
                                                  style: TextStyle(color: textFieldColor,fontWeight: FontWeight.normal,fontSize: 13.sp),
                                                  validator: (value) {
                                                    String pattern =
                                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                                    RegExp regex = new RegExp(pattern);
                                                    if (value == null ||
                                                        value.isEmpty ||
                                                        !regex.hasMatch(value)) {
                                                      return 'Please enter a valid email';
                                                    }
                                                    return null;
                                                  },
                                                  controller: emailController,
                                                  keyboardType: TextInputType.emailAddress,
                                                  maxLines: 1,
                                                  /*decoration: TextFieldDecor(
                                        text: 'Email',
                                        iconInfo: Icons.mail_outline_outlined)
                                        .addTextDecorWithIcon(),*/
                                                  decoration: InputDecoration(
                                                      prefixIcon:Icon(Icons.mail_outline_outlined, color: textFieldColor,),
                                                      hintText: 'Email*',
                                                      errorStyle: textStyle3,
                                                      hintStyle: TextStyle(color: textFieldColor,fontSize: 12.sp)
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: constraint.maxHeight*0.01),
                                              Neumorphic(
                                                style: NeumorphicStuffs().getTextFieldStyle(),
                                                child: TextFormField(
                                                  style: TextStyle(color: textFieldColor,fontWeight: FontWeight.normal,fontSize: 13.sp),
                                                  // validator: (value) {
                                                  //   String pattern =
                                                  //       r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
                                                  //   RegExp regex = new RegExp(pattern);
                                                  //   if (value == null ||
                                                  //       value.isEmpty ||
                                                  //       !regex.hasMatch(value)) {
                                                  //     return 'Please enter a valid password';
                                                  //   }
                                                  //   return null;
                                                  // },
                                                  controller: passwordController,
                                                  keyboardType: TextInputType.emailAddress,
                                                  maxLines: 1,
                                                  /*decoration: TextFieldDecor(
                                        text: 'Email',
                                        iconInfo: Icons.mail_outline_outlined)
                                        .addTextDecorWithIcon(),*/
                                                  decoration: InputDecoration(
                                                      prefixIcon:Icon(Icons.password_outlined, color:textFieldColor,),
                                                      hintText: 'Password*',
                                                      errorStyle: textStyle3,
                                                      hintStyle: TextStyle(color: textFieldColor,fontSize: 12.sp)
                                                  ),
                                                ),
                                              ),
                                        
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  child: NeumorphicStuffs().getImportantButton(
                                                      text: 'Login',
                                                      ontapped: () async {
                                                        if (_formKey.currentState!
                                                            .validate() /*&& isChecked!*/) {
                                        
                                                         bool b= await   login(context,emailController.text,passwordController.text);
                                                         if(b)
                                                         Get.offAll(()=>NavPage());
                                                        }
                                                      }
                                        
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New user?',
                      style: TextStyle(
                        color: isDarkMode?Colors.white:Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        print("Button pressed");
                       Get.to(EmailVerification());
                      },
                      child: Text(
                        'Signup',
                        style: TextStyle(
                           color: isDarkMode?Colors.white:Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: isDarkMode?Colors.white:Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                      Get.to(()=>ResetEmailVerification());
                      },
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                            color: isDarkMode?Colors.white:Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
             ]
             );
             })
             )
             )
             );
             }

             Future login(BuildContext context,String email,String password) async
             {
              API api=API();
               ResponseData logininfo=await api.login(email, password);
               if(logininfo.success!)
               {
                //UserModal userModal=await api.getUser( email,logininfo.data!.token);

                SharedPreferences preferences=await SharedPreferences.getInstance();
                                                      preferences.setString(Constants.TOKEN, "${logininfo.data!.token}"/*"${response[Constants.TOKEN]}"*/);

                                                      //Map<String,dynamic> userDetails=response['data'];
                                                      // UserData? userData=userModal.userData;
                                                      // await preferences.setString(Constants.UserId, "${userData?.id/*userDetails['email']*/}");
                                                       await preferences.setString(Constants.EMAIL, email);
                                                      
                                                      // await preferences.setBool(Constants.LOGIN_STATUS,true);

                                                       UserProvider provider=Provider.of<UserProvider>(context,listen: false);

                                                      
                                                       provider.email=email;
                                                      // provider.firstname=userData!.firstname!;
                                                      // provider.lastname=userData!.lastname!;
                                                     // provider.phoneNumber=userData!.phone!;
                                                      //provider.id=userData!.id!;
                                                      provider.token=logininfo.data!.token!;

                                                    // //List<dynamic> roleInfo=userDetails['userRoles'];
                                                    //   List<UserRoles> userRoles=userData!.userRoles!;

                                                    //   await preferences.setInt(Constants.roleId, userRoles[0]!.role!.roleId!);

                                                    //   provider.userRoleId=userRoles[0].userRoleId!;
                                                    //   provider.roleId=userRoles[0].role!.roleId!;
                                                    //   provider.roleName=userRoles[0].role!.roleName!;
                                                      //provider.enabled=userData!.enabled!;

                                                      provider.isloading=LoadingStatus.notLoading;
                                                      //provider.isInitialized=true;


                return true;

                
               }
               else
               {
                Fluttertoast.showToast(msg: logininfo.message!);
                return false;
               }
             }
}