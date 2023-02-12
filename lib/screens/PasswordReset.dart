import 'package:blogpost/screens/WelcomeScreen.dart';
import 'package:blogpost/utils/api.dart';
import 'package:blogpost/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';


import '../Modals/ForgotPassword.dart';
import '../utils/neumorphic_stuffs.dart';
class ResetPassword extends StatefulWidget {
   ResetPassword({Key? key,required this.email}) : super(key: key);
String email;
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController confirmPasswordController;

  late TextEditingController passwordController;

  void initState() {
    confirmPasswordController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(

          height: height,
          width: width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 2.h),
            child: Form(
              key: _formKey,
              child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50.h,
                            decoration: BoxDecoration(color: Colors.yellow,
                                borderRadius: BorderRadius.circular(20)),
                            // constraints: BoxConstraints(maxHeight: constraints.maxHeight*0.8 ),
                            width: constraints.maxWidth * 0.95,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: LayoutBuilder(
                                  builder: (context, constraint) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [

                                        SizedBox(height: 3.h,),
                                        Text(
                                          "Enter your new password:",
                                          style: TextStyle(
                                              color: textFieldColor,
                                              fontSize: 12.sp),),
                                        SizedBox(height: 2.h,),
                                        Neumorphic(
                                          style: NeumorphicStuffs()
                                              .getTextFieldStyle(),
                                          child: TextFormField(
                                            style: TextStyle(
                                                color: textFieldColor,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 13.sp),
                                            validator: (value) {
                                              String pattern =
                                                  r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
                                              RegExp regex = new RegExp(
                                                  pattern);
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  !regex.hasMatch(value)) {
                                                return 'Please enter a valid password';
                                              }
                                              return null;
                                            },
                                            controller: passwordController,
                                            keyboardType: TextInputType
                                                .emailAddress,
                                            maxLines: 1,
                                            /*decoration: TextFieldDecor(
                                  text: 'Email',
                                  iconInfo: Icons.mail_outline_outlined)
                                  .addTextDecorWithIcon(),*/
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.password_outlined,
                                                  color: textFieldColor,),
                                                hintText: 'Password*',
                                                hintStyle: TextStyle(
                                                    color: textFieldColor,
                                                    fontSize: 12.sp)
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: constraint.maxHeight *
                                                0.01),
                                        Neumorphic(
                                          style: NeumorphicStuffs()
                                              .getTextFieldStyle(),
                                          child: TextFormField(
                                            style: TextStyle(
                                                color: textFieldColor,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 13.sp),
                                            validator: (value) {
                                              String pattern =
                                                  r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
                                              RegExp regex = new RegExp(
                                                  pattern);
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  !regex.hasMatch(value)) {
                                                return 'Re-enter the password';
                                              }
                                              return null;
                                            },
                                            controller: confirmPasswordController,
                                            keyboardType: TextInputType
                                                .emailAddress,
                                            maxLines: 1,
                                            /*decoration: TextFieldDecor(
                                  text: 'Email',
                                  iconInfo: Icons.mail_outline_outlined)
                                  .addTextDecorWithIcon(),*/
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.password_outlined,
                                                  color: textFieldColor,),
                                                hintText: 'Confirm Password*',
                                                hintStyle: TextStyle(
                                                    color: textFieldColor,
                                                    fontSize: 12.sp)
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0,
                                              vertical: 15.0),
                                          child: Container(
                                            width: double.infinity,
                                            child: NeumorphicStuffs()
                                                .getImportantButton(
                                                text: 'Reset Password',
                                                ontapped: () async {
                                                  if (_formKey.currentState!
                                                      .validate() /*&& isChecked!*/) {
                                                    if (passwordController
                                                        .text.compareTo(
                                                        confirmPasswordController
                                                            .text) == 0) {
                                                      PasswordReset resetmodal=await resetPassword(widget.email, passwordController.text);
                                                      if(resetmodal.success!)
                                                      {
                                                        Fluttertoast.showToast(msg: resetmodal.message!);
                                                        Get.offAll(()=>WelcomeScreen());
                                                      }
                                                      else
                                                      {
                                                         Fluttertoast.showToast(msg: resetmodal.message!);
                                                      }
                                                    }
                                                  }
                                                }
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                              ),
                            )
                        ),
                        
                      ],
                    );
                  }
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<PasswordReset> resetPassword(String email,String newPassword)async
  {
    API api=API();
    PasswordReset resetModal=await api.reset(email, newPassword);
    return resetModal;
  } 
}
