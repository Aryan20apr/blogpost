// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// class SignUp extends StatelessWidget {
//   const SignUp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(child: Scaffold(backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
//     body: Container(
//       height: 100.h,
//       width: 100.w,
//       child:LayoutBuilder(builder: (context,constraints){
//         return Column(
          
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
            

//           ],

//         );
//       }),
//     ),));
//   }
// }


import 'package:blogpost/Modals/otpresponse.dart';
import 'package:blogpost/utils/Themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../utils/api.dart';
import '../utils/neumorphic_stuffs.dart';
import 'OtpVerification.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailController;

  late TextEditingController otpController;
  void initState()
  {

    emailController = TextEditingController();

    otpController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: height,
          width:width,
          child: LayoutBuilder(builder: (context,constraint){
            return Column(
              //mainAxisAlignment: MainAxisAlignment.s,
              children: [
                Container(height: 10.h,child:Center(child: Text("Please verify your email before signing up",style: TextStyle(color: isDarkMode?Colors.white:Colors.black,fontSize: 16.sp),textAlign: TextAlign.center,))),
                Container(
                  height: 70.h,
                  child: Form(
                    key: _formKey,
                      child: Container(
                        width: constraint.maxWidth*0.9,
                        height: height*0.6,
                        decoration:  BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Image.asset("assets/register.jpg",height: 30.h,),
                
                          Neumorphic(
                            style: NeumorphicStuffs().getTextFieldStyle(),
                            child: TextFormField(
                
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13.sp),
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
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.redAccent),),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.greenAccent),),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.black),),
                                  prefixIcon:Icon(color:Colors.black,Icons.mail_outline_outlined,),
                                  hintText: 'Email*',
                                  hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
                              ),
                            ),
                          ),
                      Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                            onPressed: ()async {
                              if(_formKey.currentState!.validate())
                                {
                
                                        bool b=await sendOTP(emailController.text);

                                        if(b)
                                      
                                              Get.to(()=>OtpVerification( email: emailController.text,) );
                                     
                                }
                            },
                            icon: Icon(Icons.password_sharp),
                            label: Text("Send OTP"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: Size(30.w,8.h),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                      )
                    ],
                  ),
                        ),
                      )),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
  Future sendOTP(String email)async
  {
    OTPResponse response=await NetworkUtil().sendOtp(email);
    if(response.success!)
    return true;
    else
    {
      Fluttertoast.showToast(msg: response.message!);
      return false;
    }

  }
}
