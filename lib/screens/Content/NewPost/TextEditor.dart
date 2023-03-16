import 'package:blogpost/Modals/ImageUploadResponse.dart';
import 'package:blogpost/Modals/NewPostModal.dart';
import 'package:blogpost/providers/PostProvider.dart';
import 'package:blogpost/providers/UserProvider.dart';
import 'package:blogpost/utils/api.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../Modals/CategoriesModal.dart';
import '../../../utils/neumorphic_stuffs.dart';
class CreatePost extends StatefulWidget {
   CreatePost({super.key,required this.categories});
    List<Category> categories;
  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
   final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController contentController;
   

  @override
  void initState()
  {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
    


  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<Category> items) {
  List<DropdownMenuItem<String>> _menuItems = [];
  for (var item in items) {
    _menuItems.addAll(
      [
        DropdownMenuItem<String>(
          value: '${item.categoryId}',
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '${item.categoryTitle}',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
        //If it's last item, we will not add Divider after it.
        if (item != items.last)
          const DropdownMenuItem<String>(
            enabled: false,
            child: Divider(),
          ),
      ],
    );
  }
  return _menuItems;
}
List<double> _getCustomItemsHeights() {
  List<double> _itemsHeights = [];
  for (var i = 0; i < (widget.categories.length * 2) - 1; i++) {
    if (i.isEven) {
      _itemsHeights.add(40);
    }
    //Dividers indexes will be the odd indexes
    if (i.isOdd) {
      _itemsHeights.add(4);
    }
  }
  return _itemsHeights;
}
//String? selectedValue;
  @override
  Widget build(BuildContext context) {
   

    print('Build method called');
    
    var textStyle = TextStyle(color:Theme.of(context).textTheme.headlineSmall!.color,fontSize: 14.sp,fontWeight: FontWeight.bold);
            var textStyle2 = TextStyle(color: Theme.of(context).textTheme.headlineSmall!.color,fontWeight: FontWeight.normal,fontSize: 12.sp);
            var textStyle3 = TextStyle(color:Colors.red,fontSize: 8.sp);
    var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
    return SafeArea(child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(actions: [],backgroundColor: isDarkMode?Colors.black:Colors.green.shade800,foregroundColor: Colors.white,
      title: Text('Create New Blog'),titleTextStyle: TextStyle(color: Colors.white,fontSize: 14.sp,fontWeight: FontWeight.w500),iconTheme: IconThemeData(color: Colors.white),),
      body: Container(
        height:MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
        child: SingleChildScrollView(physics: RangeMaintainingScrollPhysics(),child: LayoutBuilder(
          builder: (context , constraint ) { 
            return   Column(
                children: [
                  
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      //height: constraint.maxHeight*0.9,
                      decoration: BoxDecoration(color: Theme.of(context).cardTheme.color,borderRadius: BorderRadius.circular(20)),
                      child: Form(
                        autovalidateMode: AutovalidateMode.disabled,
                        key: _formKey,
                        child: Column(
                          children: [
                            
                            
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                              child: TextFormField(
                  onTapOutside: ((event) => FocusScope.of(context).unfocus()),
                                style: textStyle2,
                                maxLength: 50,
                                validator: (value) {
                  
                  
                                  if (value == null ||
                                      value.isEmpty ) {
                                    return 'Title cannot be empty';
                                  }
                                  return null;
                                },
                                controller: titleController,
                                keyboardType: TextInputType.text,
                                maxLines: 3,
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
                                          width: 3, color: Theme.of(context).textTheme.headlineSmall!.color!),),
                                    prefixIcon:Icon(color:Theme.of(context).textTheme.headlineSmall!.color!,LineIcons.heading,),
                                    //hintText: 'XYZ',
                                    label: Text('Blog Title*'),
                                    labelStyle: textStyle,
                                    errorStyle: textStyle3,
                                    //hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                              child: TextFormField(
                                onTapOutside: ((event) => FocusScope.of(context).unfocus()),
                                style: textStyle2,
                                validator: (value) {
                  
                  
                                  if (value == null ||
                                      value.isEmpty ) {
                                    return 'Last name cannot be empty';
                                  }
                                  return null;
                                },
                                controller: contentController,
                                keyboardType: TextInputType.emailAddress,
                                maxLines: 8,
                                maxLength: 2000,
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
                                          width: 3,color:Theme.of(context).textTheme.headlineSmall!.color!),),
                                    prefixIcon:Icon(color:Theme.of(context).textTheme.headlineSmall!.color,FontAwesomeIcons.penFancy,),
                                    //hintText: 'Last Name*',
                                    label: Text('Content*'),
                                    labelStyle: textStyle,
                                    errorStyle: textStyle3,
                                    //hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
                                ),
                              ),
                            ),
                 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChangeNotifierProvider(
                      create: (BuildContext context) { return PostProvider(); },
                      child: Consumer<PostProvider>(
                        builder: (BuildContext context, post, _) { return Column(
                          children: [
                            ListTile(leading: post.isUploaded?IconButton(onPressed: (){
                              post.removeImage();
                            }, icon: Icon(Icons.close,color: textStyle.color,)):Text('Select Image',style: textStyle,),
                              title: post.isUploaded? Text(post.imagename):Text(''),
                              
                              trailing: IconButton(icon: Icon(EvaIcons.image), onPressed: () async { 
                                await getImage(post);
                                print("File is ${post.imagefile==null}");
                               },),
                            shape:ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),tileColor: Theme.of(context).cardTheme.color ,),

                          Row(
                            children: [
                              Expanded(flex: 1,child: Text('Choose the topic for this post',style: textStyle,)),
                              Expanded(
                                flex: 1,
                                child: Center(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Text(
                                          'Select Category',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                        items: _addDividersAfterItems(widget.categories),
                                        customItemsHeights: _getCustomItemsHeights(),
                                        value: post.id,
                                        onChanged: (value) {
                                         
                                           post.updateCategory(value!);
                                          
                                        },
                                        buttonHeight: 40,
                                        dropdownMaxHeight: 200,
                                        buttonWidth: 140,
                                        itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      ),
                                    ),
                                  ),
                              ),
                            ],
                          ), Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                    child: Container(
                      width: double.infinity,
                      child: NeumorphicStuffs().getImportantButton(
                          text: 'Submit',
                          ontapped: () async {
                            if (_formKey.currentState!
                                .validate() /*&& isChecked!*/) {
                                    NewPostData postData=NewPostData();
                                    postData.content=contentController.text;
                                    postData.title=titleController.text;
                                    UserProvider provider=Provider.of<UserProvider>(context,listen: false);
                                   await createPost(postData:postData, catid: int.parse(post.id!), userid: provider.id, file: post.imagefile,);
                              
                            }
                          }
                    
                      ),
                    ),
                  ),],
                          
                        ); },
                      
                      ),
                    ),
                  ),
                  
                 
                    
                ],
              )
              )
              )
              )]
              );
           },
          
        )),      ),
    ));
  }

  Future<void> getImage(PostProvider post) async {
     var image = await ImagePicker().pickImage(source: ImageSource.gallery);
     if(image!=null)
                 post.loadImage(imagefile: image);
           
  }

  Future createPost({required NewPostData postData,required int userid,required int catid,required XFile? file})async
  {
    API api = new API();
   
     Get.showOverlay(asyncFunction: ()async{
       NewPostModal? post;
      post=   await api.createPost(postData:postData, categoryid: catid, userid: userid);
        bool? imagesuccess;
        print('File:${file==null}');
       if(file!=null)
      {
        ImageUploadResponse uploadResponse=await api.uploadImage(file, post.data!.postId!);
        imagesuccess=uploadResponse.success;
      }
      return [post.success, imagesuccess];
      
      },loadingWidget: Center(child: CircularProgressIndicator.adaptive()),opacity: 0.5).then((value) async{
         if(value[0]!&&(value[1]==null||value[1]==true))
    {
     
     Get.snackbar("Successful", "Your blog has been published",snackPosition: SnackPosition.BOTTOM,backgroundColor: /*Colors.green,colorText:Colors.white*/ Theme.of(context).snackBarTheme.backgroundColor,colorText:Theme.of(context).snackBarTheme.contentTextStyle!.color  );
     return true;
    }
    else
    {
      Get.snackbar("Failed", "Your blog has not been published or published but image not saved",snackPosition:SnackPosition.BOTTOM,backgroundColor: /*Colors.green,colorText:Colors.white*/ Theme.of(context).snackBarTheme.backgroundColor,colorText:Theme.of(context).snackBarTheme.contentTextStyle!.color  );
      return false;
    }
      });
   
  }
}