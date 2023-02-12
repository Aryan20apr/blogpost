
import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../Modals/registrationmodal.dart';
import '../../providers/UserProvider.dart';
import '../../utils/api.dart';
import '../../utils/constants.dart';
import '../../utils/neumorphic_stuffs.dart';


class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {

  //XFile? _image;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController phoneNumberController;
  late TextEditingController aboutController;

  
  void initState()
  {
    phoneNumberController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    aboutController = TextEditingController();
    usernameController = TextEditingController();


  }

  Future getImage() async {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);


      // setState(() {
      //   _image = image;
      //     print('Image Path $_image');
      // });
    }
  @override
  Widget build(BuildContext context) {
var textStyle = TextStyle(color:Colors.black,fontSize: 14.sp,fontWeight: FontWeight.bold);
            var textStyle2 = TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 10.sp);
            var textStyle3 = TextStyle(color:Colors.red,fontSize: 8.sp);
    UserProvider provider=Provider.of<UserProvider>(context);
    aboutController.text=provider.about;
    firstNameController.text=provider.firstname;
    lastNameController.text=provider.lastname;
    emailController.text=provider.email;
    //phoneNumberController.text=provider.phoneNumber;

    return SafeArea(
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Account Settings",style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),),
        
        ),
        body: Container(
         height:100.h,
        child: LayoutBuilder(builder: (context,constraint){
          
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Center(
                      child: SizedBox(
                        height: constraint.maxHeight*0.2,
                        child: Stack(
                          clipBehavior: Clip.none,
                                      fit: StackFit.expand,
                          children: [CircleAvatar(
                            child: ClipOval(
                        child: new SizedBox(
                          width: constraint.maxHeight*0.2,
                          height: constraint.maxHeight*0.2,
                          child: (provider.imagefile!=null)?Image.file(
                            File(provider.imagefile!.path),
                            fit: BoxFit.fill,
                          ):Image.network(
                            "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                            fit: BoxFit.fill,
                          ),
                        )),
                            radius: constraint.maxHeight*0.18,
                            backgroundColor: Colors.grey ,
                          ), Positioned(
                                  bottom: 0,
                                  right: 100,
                                  child: RawMaterialButton(
                                    onPressed: ()async  {

                                       var image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                       provider.updateImage(image);
                                       
                                    },
                                    elevation: 2.0,
                                    fillColor: Color(0xFFF5F6F9),
                                    child: Icon(EvaIcons.camera, color: Colors.grey,),
                                    padding: EdgeInsets.all(15.0),
                                    shape: CircleBorder(),
                                  )),]
                        ),
                      ),
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                            child: TextFormField(
                              readOnly: true,
                              initialValue: '${provider.id}',
                              style: textStyle2,
                             /* validator: (value) {
                
                
                                if (value == null ||
                                    value.isEmpty ) {
                                  return 'First name cannot be empty';
                                }
                                return null;
                              },*/
                
                              //keyboardType: TextInputType.emailAddress,
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
                                  prefixIcon:Icon(color:Colors.black,LineIcons.identificationBadge,),
                                  hintText: 'User id',
                                  label: Text('User'),
                                  labelStyle: textStyle,
                                  errorStyle: textStyle3,
                                  hintStyle: textStyle
                              ),
                            ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                            child: TextFormField(
                
                              style: textStyle2,
                              validator: (value) {
                
                
                                if (value == null ||
                                    value.isEmpty ) {
                                  return 'First name cannot be empty';
                                }
                                return null;
                              },
                              controller: firstNameController,
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
                                  prefixIcon:Icon(color:Colors.black,FontAwesomeIcons.user,),
                                  //hintText: 'XYZ',
                                  label: Text('First Name'),
                                  labelStyle: textStyle,
                                  errorStyle: textStyle3,
                                  hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                            child: TextFormField(
                
                              style: textStyle2,
                              validator: (value) {
                
                
                                if (value == null ||
                                    value.isEmpty ) {
                                  return 'Last name cannot be empty';
                                }
                                return null;
                              },
                              controller: lastNameController,
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
                                  prefixIcon:Icon(color:Colors.black,FontAwesomeIcons.user,),
                                  //hintText: 'Last Name*',
                                  label: Text('Last Name'),
                                  labelStyle: textStyle,
                                  errorStyle: textStyle3,
                                  hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                            child: TextFormField(
                              readOnly: true,
                              style: textStyle2,
                              /*validator: (value) {
                                String pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (value == null ||
                                    value.isEmpty ||
                                    !regex.hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },*/
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
                                  // hintText: 'Email*',
                                  label: Text('Email'),
                                        labelStyle: textStyle,
                                        errorStyle: textStyle3,
                                  hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
                              ),
                            ),
                          ),
                           Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                            child: TextFormField(
                              readOnly: false,
                              style: textStyle2,
                              /*validator: (value) {
                                String pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (value == null ||
                                    value.isEmpty ||
                                    !regex.hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },*/
                              controller: aboutController,
                              keyboardType: TextInputType.text,
                              maxLines: 5,
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
                                  prefixIcon:Icon(color:Colors.black,EvaIcons.book),
                                  
                                  // hintText: 'About*',
                                  label: Text('About'),
                                        labelStyle: textStyle,
                                        errorStyle: textStyle3,
                                        
                                  hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
                              ),
                            ),
                          ),
                         
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                  child: Container(
                    width: double.infinity,
                    child: NeumorphicStuffs().getImportantButton(
                        text: 'Update Profile',
                        ontapped: () async {
                          if (_formKey.currentState!
                              .validate() /*&& isChecked!*/) {
                           
                            update(context: context,id:provider.id ,firstname: firstNameController.text,lastname: lastNameController.text,email: emailController.text,about:aboutController.text);
                          }
                        }
                  
                    ),
                  ),
                ),
                  
              ],
            ),
          );
        }),
        ),
        
      ),
    );
  }
  Future update({required BuildContext context,required int id,required String firstname,required String lastname,required String email,required String about})async
  {
     API api = API();
     UserData userData = UserData();
     userData.id = id;
     userData.firstname = firstname;
     userData.lastname = lastname;
     userData.email = email;
     userData.about = about;
     SharedPreferences preferences=await SharedPreferences.getInstance();

     UserModal userModal=await api.updatUser(userData,preferences.getString(Constants.TOKEN)!);
    if(userModal.success!)
    {
      Get.snackbar("Successful", "Your profile has been updated",snackPosition: SnackPosition.BOTTOM,backgroundColor: /*Colors.green,colorText:Colors.white*/ Theme.of(context).snackBarTheme.backgroundColor,colorText:Theme.of(context).snackBarTheme.contentTextStyle!.color  );
       SharedPreferences preferences=await SharedPreferences.getInstance();
                                                     

                                                      //Map<String,dynamic> userDetails=response['data'];
                                                      UserData? userData=userModal.userData;
                                                      
                                                      await preferences.setString(Constants.EMAIL, "${userData?.email/*userDetails['email']*/}");
                                                     

                                                      UserProvider provider=Provider.of<UserProvider>(context,listen: false);

                                                      provider.updateUser(firstName:userData!.firstname!, lastName: userData.lastname!,about: userData.about!);
                                                      
                                                      
                                                     // provider.phoneNumber=userData!.phone!;
                                                      
                                                     
                                                        
                                                      

                                                    // //List<dynamic> roleInfo=userDetails['userRoles'];
                                                    //   List<UserRoles> userRoles=userData!.userRoles!;

                                                    //   await preferences.setInt(Constants.roleId, userRoles[0]!.role!.roleId!);

                                                    //   provider.userRoleId=userRoles[0].userRoleId!;
                                                    //   provider.roleId=userRoles[0].role!.roleId!;
                                                    //   provider.roleName=userRoles[0].role!.roleName!;
                                                      //provider.enabled=userData!.enabled!;

                                                      provider.isloading=LoadingStatus.notLoading;
                                                      provider.isInitialized=true;
    }
    else
    {
      Get.snackbar("Failed", "Your profile could not be updated",snackPosition: SnackPosition.BOTTOM,backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,colorText:Theme.of(context).snackBarTheme.contentTextStyle!.color);
    }
  }


}
