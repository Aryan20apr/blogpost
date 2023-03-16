
import 'dart:developer';
import 'dart:io';

import 'package:blogpost/Modals/CategoriesModal.dart';
import 'package:blogpost/Modals/UserPostsModal.dart';
import 'package:blogpost/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Modals/AllPostsModal.dart';
import '../Modals/CommentModal.dart';
import '../Modals/ForgotPassword.dart';
import '../Modals/ImageUploadResponse.dart';
import '../Modals/OTPVerifyModal.dart';
import '../Modals/SubscriptionResponseModal.dart';
import '../Modals/loginmodal.dart';
import '../Modals/otpresponse.dart';
import '../Modals/registrationmodal.dart';
import '../Modals/NewPostModal.dart';

class API{

  static const String BASE="https://68e2-14-139-240-85.in.ngrok.io";
  static const String signin="$BASE/api/auth/login";
  static const String user="$BASE/api/users/single";
  static const String sendotp="$BASE/api/auth/sendotp";
  static const String register="$BASE/api/auth/register";
  static const String otp="$BASE/api/auth/verifyotp";
  static const String check="$BASE/api/auth/check";
  static const String resetPassword="$BASE/api/auth/forgotpassword";
  static const String resetotp="$BASE/api/auth/sendresetotp";
  static const String updatePassword="$BASE/api/users/changepassword";

  static const String updateUser="$BASE/api/users/";

  static const String usercategories="$BASE/api/usercategories";
  static const String allcategories="$BASE/api/categoryList";
  static const String subscribe="$BASE/api/category/subscribe";
  static const String unsubscribe="$BASE/api/category/unsubscribe";
  static const String post="$BASE/api/user/posts";
  static const String upload="$BASE/api/blob/post/upload";
  static const String postbyuser="$BASE/api/userposts";
  static const String postbycategory="$BASE/api/category/posts";
  static const String updatepost="$BASE/api/post/update";
   static const String deletepost="$BASE/api/post/delete";
   static const String allposts="$BASE/api/posts";

  static const String comment="$BASE/api/comments/co";
  

    Dio _dio=Dio();

 Options getOptions(String? token)
  {
    Options options = Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {HttpHeaders.authorizationHeader:'Bearer $token'});
    return options;
  }
Future<ResponseData> login(String email,String password) async
{
  print("Email and passeord: $email, $password");
   Map<String, dynamic> query = {
      "username": email,
      "password": password
    };
    print(query);
    Response response = await _dio.post(signin, data: query);
    print("Login response is $response");
    //Map<String, dynamic> data = response.data;

   return ResponseData.fromJson(response.data);
    //return data;

}
Future<UserModal> getUser(String email,String? token) async
{
  print("Email=$email");
    Map<String, dynamic> query = {
      "email": email,
    };

    print('token=$token');

    Options options = getOptions(token);
     Response? response;
    try{

    response = await _dio.get(user, queryParameters: query,options: options );
    print(response);
    //Map<String, dynamic> data = response.data;


    return UserModal.fromJson(response.data);
    }
    catch(e)
    {
      log("Error: ${e.toString()}");
      return UserModal(data: null,message: response!.data["message"],success:false);
    }
    

}
Future<OTPResponse> sendOtp(String email) async {
    Map<String, dynamic> query = {
      "email": email,
    };

    Response response = await _dio.post(sendotp, queryParameters: query);
    //Map<String, dynamic> data = response.data;
    print("OTP RESOPNSE $response");
    return OTPResponse.fromJson(response.data);

   
  }
  Future<OTPResponse> sendresetOtp(String email) async {
    Map<String, dynamic> query = {
      "email": email,
    };

    Response response = await _dio.post(resetotp, queryParameters: query);
    //Map<String, dynamic> data = response.data;
    print("OTP RESOPNSE $response");
    return OTPResponse.fromJson(response.data);

   
  }

  Future<OTPVerifyModal> verifyOtp(int otpn,String email) async {
    Map<String, dynamic> query = {
      "otp": otpn,
      "email" : email
    };

    Response response = await _dio.post(otp, queryParameters: query);
    //Map<String, dynamic> data = response.data;
    print("OTP verification RESOPNSE $response");
    return OTPVerifyModal.fromJson(response.data);

   
  }
  Future<UserModal> registerUser(UserData user) async {
   
    Map<String,dynamic> req={
    "firstname":user.firstname,
    "lastname":user.lastname,
    "email":user.email,
    "password":user.password,
    "about":"",
    "imagename" : null
};
print("req=$req");
    Response response = await _dio.post(register, data: req);
    //Map<String, dynamic> data = response.data;
    print("Register $response");
    return UserModal.fromJson(response.data);

   
  }
  Future checkUser(String email) async {
   

    Response response = await _dio.get(check, queryParameters: {"email":email});
    //Map<String, dynamic> data = response.data;
    print("Check $response");
    return response.data['data'];

   
  }

Future<PasswordReset> reset(String email,String newPassword) async {
   

    Response response = await _dio.post(resetPassword, queryParameters: {"email":email,"newpassword":newPassword});
    
    print("Check $response");
    PasswordReset passwordmodal=PasswordReset.fromJson(response.data);
    return passwordmodal;

   
  }

  Future<PasswordReset> changePassword(String oldPassword,String newPassword) async {
   
 SharedPreferences preferences=await SharedPreferences.getInstance();
    Options options=getOptions(preferences.getString(Constants.TOKEN));
    Response response = await _dio.post(updatePassword, data: {"email":preferences.getString(Constants.EMAIL),"password":oldPassword,"newpassword":newPassword},options: options);
    
    print("Password Update Response $response");
    PasswordReset passwordmodal=PasswordReset.fromJson(response.data);
    return passwordmodal;

   
  }
  Future<UserModal> updatUser(UserData user,String token)async{
    Options options=getOptions(token);
    Response response = await _dio.put(updateUser,data:user.toJson(),options: options);
    
    print('Update user response $response');
   UserModal usermodal=UserModal.fromJson(response.data);
    return usermodal;

  }

  Future<CategoriesModal> getAllCategories()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    Options options=getOptions(preferences.getString(Constants.TOKEN));
    Response response = await _dio.get(allcategories,options: options);
    
    print('All categories response is  $response');
   CategoriesModal categoriesModal=CategoriesModal.fromJson(response.data);
    return categoriesModal;

  }
  Future<CategoriesModal> getUserCategories()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    Options options=getOptions(preferences.getString(Constants.TOKEN));
    Map<String,int> query={"userid":int.parse(preferences.getString(Constants.UserId)!)};
    log("Categories api called with query $query");
    Response response = await _dio.get(usercategories,options: options,queryParameters: query);
    
    print('Subscribed categories response is  $response');
   CategoriesModal categoriesModal=CategoriesModal.fromJson(response.data);
    return categoriesModal;

  }

  Future<NewPostModal> createPost({required int userid,required int categoryid,required NewPostData postData})async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    Options options=getOptions(preferences.getString(Constants.TOKEN));

    
    Map<String,int> query={"userId" : userid, "categoryId" : categoryid};
    Response response = await _dio.post(post,options: options,data: postData.toJson(),queryParameters: query);
    
    print('New Post response is $response');
   NewPostModal modal=NewPostModal.fromJson(response.data);
    return modal;
  }

  Future<NewPostModal> updatePost({required int postid,required NewPostData postData,required bool iremoved})async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    Options options=getOptions(preferences.getString(Constants.TOKEN));

    
    Map<String,dynamic> query={"postId" : postid, "iremoved" : iremoved};
    Response response = await _dio.put(updatepost,options: options,data: postData.toJson(),queryParameters: query);
    
    print('Update Post response is $response');
   NewPostModal modal=NewPostModal.fromJson(response.data);
    return modal;
  }

  Future<ImageUploadResponse> uploadImage(XFile? file, int id)async
  {
   var formData = FormData.fromMap({
  
  'file': await MultipartFile.fromFile(file!.path,filename: file.name)
});
SharedPreferences preferences=await SharedPreferences.getInstance();
    Options options=getOptions(preferences.getString(Constants.TOKEN));
Response response = await _dio.post(upload, data: formData,queryParameters: {"id":id},options: options);
print('Image Upload response is ${response}');

return ImageUploadResponse.fromJson(response.data);
  }
    Future<UserPostsModal> getUserPosts()async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    Options options=getOptions(preferences.getString(Constants.TOKEN));

    
    Map<String,int> query={"userId" : int.parse(preferences.getString(Constants.UserId)!)};
    Response response = await _dio.get(postbyuser,options: options,queryParameters: query);
    
    print('User Posts response is $response');
   UserPostsModal modal=UserPostsModal.fromJson(response.data);
    return modal;
  }

  Future<CategoryPosts> getCategoryPosts(int categoryId)async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    Options options=getOptions(preferences.getString(Constants.TOKEN));

    
    Map<String,int> query={"categoryId" : categoryId};
    Response response = await _dio.get(postbycategory,options: options,queryParameters: query);
    
    print('Category Posts response is $response');
   CategoryPosts modal=CategoryPosts.fromJson(response.data);
    return modal;
  }
  Future<AllPostsModal> getAllPosts({required int pageNumber})async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    Options options=getOptions(preferences.getString(Constants.TOKEN));

    
    Map<String,int> query={"pageNumber":pageNumber,"pageSize":Constants.PAGE_SIZE};
    Response response = await _dio.get(allposts,options: options,queryParameters: query);
    
    print('All Posts response is $response');
   AllPostsModal modal=AllPostsModal.fromJson(response.data);
    return modal;
  }

  Future deletePost(int postid)async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    Options options=getOptions(preferences.getString(Constants.TOKEN));
    Response response=await _dio.delete(deletepost, options:options,queryParameters: {"postId":postid});
  print('Delete Posts response is $response');
  if(response.data["success"])
  return true;
  else
  return false;
    }

    Future<SubscriptionResponseModal> subscribeCategories({required List<int> catids})async
{
  SharedPreferences preferences=await SharedPreferences.getInstance();
    Options options=getOptions(preferences.getString(Constants.TOKEN));

    
    Map<String,dynamic> data={"userid" : int.parse(preferences.getString(Constants.UserId)!),
                "fcmtoken":preferences.getString(Constants.FCM_TOKEN)!,  "catids":catids};
    Response response=await _dio.post(subscribe,options:options,data:data);
    print('Subscription response is $response');

    return SubscriptionResponseModal.fromJson(response.data);
}

Future<SubscriptionResponseModal> unsubscribeCategories({required List<int> catids})async
{
  SharedPreferences preferences=await SharedPreferences.getInstance();
    Options options=getOptions(preferences.getString(Constants.TOKEN));

    
    Map<String,dynamic> data={"userid" : int.parse(preferences.getString(Constants.UserId)!),
                "fcmtoken":preferences.getString(Constants.FCM_TOKEN)!,  "catids":catids};
    Response response=await _dio.put(unsubscribe,options:options,data:data);
    print('Unsubscription response is $response');

    return SubscriptionResponseModal.fromJson(response.data);
}

Future<CommentsListDTO> getComments({required int postId})async
{
SharedPreferences preferences=await SharedPreferences.getInstance();
    Options options=getOptions(preferences.getString(Constants.TOKEN));

    
    Map<String,dynamic> data={"postId" : postId};
    Response response=await _dio.get(comment,options:options,queryParameters: data);
    print('Comments of post $postId $response');

    return CommentsListDTO.fromJson(response.data);
}

Future<Comment> postComment({required int postId,required String text})async
{
SharedPreferences preferences=await SharedPreferences.getInstance();
    Options options=getOptions(preferences.getString(Constants.TOKEN));

    
    Map<String,dynamic> data={"postId" : postId,"userId":preferences.getString(Constants.UserId)};
    Response response=await _dio.post(comment,options:options,queryParameters: data,data: {"content" : text});
    print('Comment post response $postId $response');

    return Comment.fromJson(response.data);
}
  }

