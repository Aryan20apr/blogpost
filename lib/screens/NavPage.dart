import 'dart:developer';

import 'package:blogpost/Modals/CategoriesModal.dart';
import 'package:blogpost/providers/NavPageController.dart';
import 'package:blogpost/screens/Content/NewPost/TextEditor.dart';
import 'package:blogpost/utils/colors.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sizer/sizer.dart';

import '../Modals/registrationmodal.dart';
import '../providers/UserProvider.dart';
import '../utils/api.dart';
import '../utils/constants.dart';
import 'Content/CategoriesPage.dart';
import 'Content/HomeScreen.dart';
import 'Content/SettingsPage.dart';
import 'Content/UserPosts.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  //NavController navController=Get.put(NavController());

  final List<Widget> _pages=[HomePage(),CategoriesPage(),UserPosts(),SettingsPage()];
late Future <UserModal> user;
  late PageController pageController;
  int _selectedIndex=0;
  late SharedPreferences preferences;
   @override
  void initState() {
    super.initState();
    pageController = PageController();
    user=getUser();
  }

  Future<UserModal> getUser()async
  {
    preferences=await SharedPreferences.getInstance();
    return await NetworkUtil().getUser(preferences.getString(Constants.EMAIL)!, preferences.getString(Constants.TOKEN));

    //provider.updateLoadingStatus(LoadingStatus.notLoading);

  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    //navController.changePageIndex(index);
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
   // navController.changePageIndex(index);
  }
  @override
  Widget build(BuildContext context) {

    UserProvider provider=Provider.of<UserProvider>(context);
     var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Home"),
      // ),
      body: FutureBuilder(
        future: user,
        builder: ( context, snapshot) {  
          if(snapshot.hasData)
          {
            initialize(snapshot.data!,context);
         return PageView(
          children: _pages,
          controller: pageController,
          onPageChanged: onPageChanged,
        );}
        else
        {
          return LoadingWidget();
        }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,//navController.selectedIndex.value,
        backgroundColor: Colors.grey[300],
        onTap: _onTapped,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(EvaIcons.home),
          ),
          BottomNavigationBarItem(
            label: "Topics",
            icon: Icon(Icons.category_rounded),
          ),
           BottomNavigationBarItem(
            label: "My Posts",
            icon: Icon(EvaIcons.person),
          ),
           BottomNavigationBarItem(
            label: "Settings",
            icon: Icon(EvaIcons.settings),
          ),
        ],
      ),
     
      floatingActionButton: FloatingActionButton.extended(onPressed:provider.isInitialized?()async{
     
      Get.showOverlay(asyncFunction: ()async{
         CategoriesModal categories;
 categories= await NetworkUtil().getAllCategories();
 Get.to(()=>CreatePost(categories:categories.data!));
      },loadingWidget: Center(child: CircularProgressIndicator.adaptive()),opacity: 0.5);
        
      }:(){
        log("Floating Action Button Tapped and provider not initialized ${provider.isInitialized}");
      },backgroundColor: floatingbuttonbackground,foregroundColor: floatingbuttonforeground, label: Icon(EvaIcons.plus),shape: CircleBorder(),),
    );
  }

  void initialize(UserModal userModal,BuildContext context)async {
UserProvider provider=Provider.of<UserProvider>(context,);
log("Provider initialized: ${provider.isInitialized}");
if(provider.isInitialized)
return;
    UserData? userData=userModal.userData;
    log("User id: ${userData?.id/*userDetails['email']*/}");
                                                      await preferences.setString(Constants.UserId, "${userData?.id/*userDetails['email']*/}");
                                                      await preferences.setString(Constants.EMAIL, "${userData?.email/*userDetails['email']*/}");
                                                      await preferences.setString(Constants.IMAGE, "${userData?.image/*userDetails['email']*/}");
                                                      await preferences.setBool(Constants.LOGIN_STATUS,true);
                                                      
                                                      

                                                      
                                                      provider.email=userData!.email!;
                                                      provider.firstname=userData.firstname!;
                                                      provider.lastname=userData.lastname!;
                                                     // provider.phoneNumber=userData!.phone!;
                                                      provider.id=userData.id!;
                                                      provider.about=userData.about!;
                                                      provider.token=preferences.getString(Constants.TOKEN)!;
                                                       provider.imagename=userData.image;
                                                       provider.imageUrl=userData.imageurl;
                                                    // //List<dynamic> roleInfo=userDetails['userRoles'];
                                                    //   List<UserRoles> userRoles=userData!.userRoles!;

                                                    //   await preferences.setInt(Constants.roleId, userRoles[0]!.role!.roleId!);

                                                    //   provider.userRoleId=userRoles[0].userRoleId!;
                                                    //   provider.roleId=userRoles[0].role!.roleId!;
                                                    //   provider.roleName=userRoles[0].role!.roleName!;
                                                      //provider.enabled=userData!.enabled!;

                                                      provider.isloading=LoadingStatus.notLoading;
                                                      provider.updateInitialization();

  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
         height: 10.h,
              width: 10.h,
        child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase, /// Required, The loading type of the widget
          colors: const [Colors.red,Colors.blue,Colors.green,Colors.yellow],       /// Optional, The color collections
          strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
          //backgroundColor: Colors.black,      /// Optional, Background of the widget
          //pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
                ),
      ),
    );
  }
}