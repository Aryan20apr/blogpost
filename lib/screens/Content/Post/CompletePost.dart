import 'package:blogpost/Modals/UserPostsModal.dart';
import 'package:blogpost/providers/RefreshProvider.dart';
import 'package:blogpost/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../Modals/AllPostsModal.dart';
import '../../../utils/api.dart';
import 'EditPost.dart';

class Post extends StatefulWidget {
   Post({super.key, this.post=null,this.type=PostType.EXPLORE,this.apost=null});
  UserPostData? post;
  PostType type;
  Content? apost;
  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  
  @override
  Widget build(BuildContext context) {
    var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
    
   
    return SafeArea(child:Scaffold(
      appBar: AppBar(
        elevation: 0.0,
     
        actions: widget.type==PostType.EXPLORE?[]:[PopupMenuButton(itemBuilder: (context){
          return [PopupMenuItem(child: Text('Delete Post'),value: 0,),PopupMenuItem(child: Text('Edit Post'),value: 1,)];
        },
        onSelected: (value)async{
          if(value==0)
          {
           bool b=false;
          return  showDialog<void>(context: context, builder: (BuildContext context){
            return AlertDialog( // <-- SEE HERE
        title: const Text('Delete Post'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Are you sure want to delete this post?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () async{
              NetworkUtil api=NetworkUtil();
              b= await api.deletePost(widget.post!.postId!);
              
              int count=0;
              RefreshProvider provider=Provider.of<RefreshProvider>(context,listen:false);
              provider.changeRefresh();
            //  Navigator.popUntil(context, (route) {
            //    return count++==2; 
            //  });
            Navigator.pop(context);
            Get.back(result: true);
               
            },
          ),
        ],
      );
      
           });
            
   
  
          }
          else if(value==1)
          {
            setState(()async
            {
           widget.post= await Get.to(()=>EditPost(post:widget.post!));});
          }
        },
        )],
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,

      ),
      body: Container(
        decoration:!isDarkMode?  BoxDecoration(image: DecorationImage(image: AssetImage('assets/background.jpg',),fit: BoxFit.fill,)):BoxDecoration(),
        height: 100.h,
        width: 100.w,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: 100.h,
            width: 95.w,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                              width: 95.w,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).cardTheme.color),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: widget.type==PostType.USERPOSTS? Personal(context):Explore(context),
                    ),
                            ),
                ),
                  Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:widget.type==PostType.USERPOSTS? UserContentWidget(context):ExploreContentWidget(context),
                  ))
                
              ],
             
            ),
          ),
        ),
      ),
    ));
  }

  Container UserContentWidget(BuildContext context) {
    return Container(
            width: 95.w,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Theme.of(context).cardTheme.color),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
          children: [  widget.post!.imageUrl!=null?Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage( width: 95.w,
              height:20.h,placeholder:((context, url) => Image.asset(fit: BoxFit.cover,'assets/no_image.jpg')) ,imageUrl: '${widget.post!.imageUrl}?si=Client%20Read&spr=https&sv=2021-06-08&sr=c&sig=Ph0eekL09Jv82offqeob14Lyhg7oZNI611YPmKjsx5g%3D'),
            ),
          ):SizedBox(height: 0.0,width: 0.0,),
            
                                 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${widget.post!.content!}',style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12.sp),),
          )],                  ),
          );
  }
  Container ExploreContentWidget(BuildContext context) {
    return Container(
            width: 95.w,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Theme.of(context).cardTheme.color),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
          children: [  widget.apost!.imageUrl!=null?Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage( width: 95.w,
              height:20.h,placeholder:((context, url) => Image.asset(fit: BoxFit.fill,'assets/no_image.jpg')) ,imageUrl: '${widget.apost!.imageUrl}?si=Client%20Read&spr=https&sv=2021-06-08&sr=c&sig=Ph0eekL09Jv82offqeob14Lyhg7oZNI611YPmKjsx5g%3D'),
            ),
          ):SizedBox(height: 0.0,width: 0.0,),
            
                                 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${widget.apost!.content!}',style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12.sp),),
          )],                  ),
          );
  }

  Column Personal(BuildContext context) {
     DateTime dateTime=DateTime.parse(widget.post!.addedDate!);

    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                            children: [ RichText(text: TextSpan(children: [
                              TextSpan(text:'You',style: Theme.of(context).textTheme.titleMedium),
                              TextSpan(text: ' in',style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.normal)),
                              TextSpan(text: ' ${widget.post!.category!.categoryTitle!}',style: Theme.of(context).textTheme.titleMedium)
                            ])), Text('${widget.post!.title}',style: Theme.of(context).textTheme.titleLarge),Text('${dateTime.day}/${dateTime.month}/${dateTime.year}',style: Theme.of(context).textTheme.titleMedium) ],
                            
                    );
  }
  Column Explore(BuildContext context) {
     
     DateTime dateTime=DateTime.parse(widget.apost!.addedDate!);
    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                            children: [ RichText(text: TextSpan(children: [
                              TextSpan(text:'${widget.apost!.user!.firstname} ${widget.apost!.user!.lastname}',style: Theme.of(context).textTheme.titleMedium),
                              TextSpan(text: ' in',style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.normal)),
                              TextSpan(text: ' ${widget.apost!.category!.categoryTitle!}',style: Theme.of(context).textTheme.titleMedium)
                            ])), Text('${widget.apost!.title}',style: Theme.of(context).textTheme.titleLarge),Text('${dateTime.day}/${dateTime.month}/${dateTime.year}',style: Theme.of(context).textTheme.titleMedium) ],
                            
                    );
  }
}