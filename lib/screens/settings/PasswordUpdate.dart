import 'dart:developer';

import 'package:blogpost/Modals/ForgotPassword.dart';
import 'package:blogpost/screens/settings/PasswordChange.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/api.dart';
import '../../utils/colors.dart';
import '../../utils/neumorphic_stuffs.dart';
import '../NavPage.dart';

class UpdatePassword extends StatefulWidget {
 UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController currentpasswordController=TextEditingController();

  TextEditingController newPasswordController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    

    
    return Scaffold(appBar: AppBar(
          title: Text("Change Password",style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),),
        
        ),
        body: Container(height: 100.h,
        child:Form
        (
          key: _formKey,
          child: LayoutBuilder(builder: (context,constraint){
            
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Neumorphic(
                                           style: NeumorphicStuffs().getTextFieldStyle(),
                                           child: TextFormField(
                                             obscureText: true,
                                             style: TextStyle(color: textFieldColor,fontWeight: FontWeight.normal,fontSize: 10.sp),
                                             validator: (value) {
                                               String pattern =
                                                   
                                                   r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$";
                                               RegExp regex = new RegExp(pattern);
                                               if (value == null ||
                                                   value.isEmpty ||
                                                   !regex.hasMatch(value)) {
                                                 return 'Please enter a valid password';
                                               }
                                               return null;
                                             },
                                             controller: currentpasswordController,
                                             keyboardType: TextInputType.emailAddress,
                                             maxLines: 1,
                                             /*decoration: TextFieldDecor(
                                      text: 'Email',
                                      iconInfo: Icons.mail_outline_outlined)
                                      .addTextDecorWithIcon(),*/
                                             decoration: InputDecoration(
                                                 prefixIcon:Icon(Icons.password_outlined, color:textFieldColor,),
                                                 hintText: 'Current Password*',
                                                 hintStyle: TextStyle(color: textFieldColor,fontSize: 10.sp)
                                             ),
                                           ),
                                         ),
                                         
                                         SizedBox(height: constraint.maxHeight*0.01),
                                          Neumorphic(
                                           style: NeumorphicStuffs().getTextFieldStyle(),
                                           child: TextFormField(
                                             obscureText: true,
                                             style: TextStyle(color: textFieldColor,fontWeight: FontWeight.normal,fontSize: 10.sp),
                                             validator: (value) {
                                               String pattern =
                                                   r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$";
                                               RegExp regex = new RegExp(pattern);
                                               if (value == null ||
                                                   value.isEmpty ||
                                                   !regex.hasMatch(value)) {
                                                 return 'Please enter a valid password';
                                               }
                                               return null;
                                             },
                                             controller: newPasswordController,
                                             keyboardType: TextInputType.emailAddress,
                                             maxLines: 1,
                                             /*decoration: TextFieldDecor(
                                      text: 'Email',
                                      iconInfo: Icons.mail_outline_outlined)
                                      .addTextDecorWithIcon(),*/
                                             decoration: InputDecoration(
                                                 prefixIcon:Icon(Icons.password_outlined, color:textFieldColor,),
                                                 hintText: 'New Password*',
                                                 hintStyle: TextStyle(color: textFieldColor,fontSize: 10.sp)
                                             ),
                                           ),
                                         ),
            
                                         SizedBox(height: constraint.maxHeight*0.01),
                                         
                                       
                                                                               Padding(
                                           padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                                           child: Container(
                                             width: double.infinity,
                                             child: NeumorphicStuffs().getImportantButton(
                                                 text: 'Update Password',
                                                 ontapped: () async {
                                                   if (_formKey.currentState!
                                                       .validate() /*&& isChecked!*/) {
            
                                                        Get.showOverlay(loadingWidget: Center(child: Container(height:0.1.h,width: 0.1.h,child: CircularProgressIndicator.adaptive())),asyncFunction: () async{
                                                           PasswordReset b=await changePassword(currentpasswordController.text,newPasswordController.text);

                                                          if(b.success!)
                                                          {
                                                            Get.snackbar("Successfull", b.message!,snackPosition: SnackPosition.BOTTOM,backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,colorText:Theme.of(context).snackBarTheme.contentTextStyle!.color);
                                                          }
                                                          else
                                                          {
                                                            Get.snackbar("Failed", b.message!,snackPosition: SnackPosition.BOTTOM,backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,colorText:Theme.of(context).snackBarTheme.contentTextStyle!.color);
                                                          }

                                                        },);
                                                        //PasswordReset b=await changePassword(currentpasswordController.text,newPasswordController.text);
                                                        // if(b.success!)
                                                        // {
                                                          
                                                        // }
                                                   }
                                                 }
            
                                             )
                                           )
                                                                               )
              ],),
            );
               
          }
          ),
        )
        )
        );
  }

  Future<PasswordReset> changePassword(String old,String newPassword)async
  {
    log("Inside ChangePassword");

      return API().changePassword(old, newPassword);
  }
}