
import 'package:blogpost/utils/api.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Modals/loginmodal.dart';
import '../Modals/registrationmodal.dart';
import '../providers/UserProvider.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/neumorphic_stuffs.dart';
import 'NavPage.dart';



class RegistrationPage extends StatefulWidget {
   RegistrationPage({Key? key,required this.email}) : super(key: key);
  String email;
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}
Color textFieldColor=Colors.black;
class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  
  
  late TextEditingController passwordController;
  //AccountType? _accountType=null;

  @override
  void initState()
  {
    super.initState();
    //phoneNumberController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    //usernameController = TextEditingController();
    
    emailController.text=widget.email;
  }
  @override
  Widget build(BuildContext context) {
    
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
            body: Container(

              height: height,
              width: width,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 3.h,vertical: 2.h),
                child: Form(
                  key: _formKey,
                  child: LayoutBuilder(
                    builder: (context,constraints) {
                      return Column(

                        children: [
                          Expanded(
                            flex: 9,
                            child: Container(
                                decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(20)),
                            // constraints: BoxConstraints(maxHeight: constraints.maxHeight*0.8 ),
                             width: constraints.maxWidth*0.95,
                             child:Padding(
                               padding: const EdgeInsets.all(15.0),
                               child: LayoutBuilder(
                                 builder: (context,constraint) {
                                   return Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       
                                       
                                       Neumorphic( style:NeumorphicStuffs().getTextFieldStyle(),
                                         child: TextFormField(
                                           style: TextStyle(color: textFieldColor,fontWeight: FontWeight.normal,fontSize: 10.sp),
                                           validator: (value) {
                                             if (value == null || value.isEmpty) {
                                               return 'Please enter a valid first name';
                                             }
                                             return null;
                                           },
                                           controller: firstNameController,
                                           keyboardType: TextInputType.name,
                                           maxLines: 1,
                                           decoration: InputDecoration(
                                               prefixIcon:Icon(Icons.account_circle_outlined,color: textFieldColor,),
                                               hintText: 'First Name*',
                                               hintStyle: TextStyle(color: textFieldColor,fontSize: 10.sp)
                                           ),
                                         ),),
                                       SizedBox(height: constraint.maxHeight*0.01),
                                       Neumorphic( style:NeumorphicStuffs().getTextFieldStyle(),
                                         child: TextFormField(
                                           style: TextStyle(color: textFieldColor,fontWeight: FontWeight.normal,fontSize: 10.sp),
                                           validator: (value) {
                                             if (value == null || value.isEmpty) {
                                               return 'Please enter a valid last name';
                                             }
                                             return null;
                                           },
                                           controller: lastNameController,
                                           keyboardType: TextInputType.name,
                                           maxLines: 1,
                                           decoration: InputDecoration(
                                               prefixIcon:Icon(Icons.account_circle_outlined,color: textFieldColor,),
                                               hintText: 'Last Name*',
                                               hintStyle: TextStyle(color: textFieldColor,fontSize: 10.sp)
                                           ),
                                         ),),
                                       SizedBox(height: constraint.maxHeight*0.01),
                                        Neumorphic(
                                         style: NeumorphicStuffs().getTextFieldStyle(),
                                         child: TextFormField(
                                           readOnly: true,
                                           style: TextStyle(color: textFieldColor,fontWeight: FontWeight.normal,fontSize: 10.sp),
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
                                                 r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
                                             RegExp regex = new RegExp(pattern);
                                             if (value == null ||
                                                 value.isEmpty ||
                                                 !regex.hasMatch(value)) {
                                               return 'Please enter a valid password';
                                             }
                                             return null;
                                           },
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
                                               text: 'Register',
                                               ontapped: () async {
                                                 if (_formKey.currentState!
                                                     .validate() /*&& isChecked!*/) {

                                                      bool b=await registerUser(firstNameController.text,lastNameController.text,emailController.text,passwordController.text);
                                                      if(b)
                                                      {
                                                        Get.offAll(NavPage());
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
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.displaySmall!.color,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: darkTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
  Future registerUser(String firstname,String lastname,String email,String password)async
  { API api=API();
      UserData data = new UserData();
      data.firstname=firstname; 
      data.lastname=lastname;
      data.email=email;
      data.password=password;
      UserModal userModal=await api.registerUser(data);
      if(userModal.success!)
      {

       
               ResponseData logininfo=await api.login(email, password);
               if(logininfo.success==false)
               {
                Fluttertoast.showToast(msg: logininfo.message!);
                return false;
               }
         SharedPreferences preferences=await SharedPreferences.getInstance();
                                                      preferences.setString(Constants.TOKEN, "${logininfo.data!.token}"/*"${response[Constants.TOKEN]}"*/);

                                                      //Map<String,dynamic> userDetails=response['data'];
                                                      UserData? userData=userModal.userData;
                                                      await preferences.setString(Constants.UserId, "${userData?.id/*userDetails['email']*/}");
                                                      await preferences.setString(Constants.EMAIL, "${userData?.email/*userDetails['email']*/}");
                                                      await preferences.setString(Constants.IMAGE, "${userData?.image/*userDetails['email']*/}");

                                                      await preferences.setBool(Constants.LOGIN_STATUS,true);

                                                      UserProvider provider=Provider.of<UserProvider>(context,listen: false);

                                                      
                                                      provider.email=userData!.email!;
                                                      provider.firstname=userData.firstname!;
                                                      provider.lastname=userData.lastname!;
                                                     // provider.phoneNumber=userData!.phone!;
                                                      provider.id=userData.id!;
                                                      provider.imagename=userData.image;
                                                      provider.about=userData.about!;
                                                      provider.token=logininfo.data!.token!;
                                                      provider.imageUrl=userData.imageurl;

                                                    // //List<dynamic> roleInfo=userDetails['userRoles'];
                                                    //   List<UserRoles> userRoles=userData!.userRoles!;

                                                    //   await preferences.setInt(Constants.roleId, userRoles[0]!.role!.roleId!);

                                                    //   provider.userRoleId=userRoles[0].userRoleId!;
                                                    //   provider.roleId=userRoles[0].role!.roleId!;
                                                    //   provider.roleName=userRoles[0].role!.roleName!;
                                                      //provider.enabled=userData!.enabled!;

                                                      provider.isloading=LoadingStatus.notLoading;
                                                      provider.isInitialized=true;

        return true;
      }
      else
      {
        Fluttertoast.showToast(msg: userModal.message!);
        return false;
      }
  }
}
