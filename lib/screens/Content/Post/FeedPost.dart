// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:sizer/sizer.dart';

// import '../../../Modals/AllPostsModal.dart';

// class FeedPost extends StatefulWidget {
//    FeedPost({ super.key,required post,categoryTitle="",firstName=""});
//   Content? post;
//   String? categoryTitle;
//   String? firstName;

//   @override
//   State<FeedPost> createState() => _FeedPostState();
// }

// class _FeedPostState extends State<FeedPost> {
//   @override
//   Widget build(BuildContext context) {
//     var brightness=SchedulerBinding.instance.window.platformBrightness;
//     bool isDarkMode=brightness==Brightness.dark;
    
   
//     return SafeArea(child:Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
     
//         actions: widget.type==PostType.EXPLORE?[]:[PopupMenuButton(itemBuilder: (context){
//           return [PopupMenuItem(child: Text('Delete Post'),value: 0,),PopupMenuItem(child: Text('Edit Post'),value: 1,)];
//         },
//         onSelected: (value)async{
//           if(value==0)
//           {
//            bool b=false;
//           return  showDialog<void>(context: context, builder: (BuildContext context){
//             return AlertDialog( // <-- SEE HERE
//         title: const Text('Delete Post'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: const <Widget>[
//               Text('Are you sure want to delete this post?'),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('No'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             child: const Text('Yes'),
//             onPressed: () async{
//               API api=API();
//               b= await api.deletePost(widget.post!.postId!);
              
//               int count=0;
//               RefreshProvider provider=Provider.of<RefreshProvider>(context,listen:false);
//               provider.changeRefresh();
//             //  Navigator.popUntil(context, (route) {
//             //    return count++==2; 
//             //  });
//             Navigator.pop(context);
//             Get.back(result: true);
               
//             },
//           ),
//         ],
//       );
      
//            });
            
   
  
//           }
//           else if(value==1)
//           {
//             setState(()async
//             {
//            widget.post= await Get.to(()=>EditPost(post:widget.post!));});
//           }
//         },
//         )],
//         foregroundColor: Theme.of(context).appBarTheme.foregroundColor,

//       ),
//       body: Container(
//         decoration:!isDarkMode?  BoxDecoration(image: DecorationImage(image: AssetImage('assets/background.jpg',),fit: BoxFit.fill,)):BoxDecoration(),
//         height: 100.h,
//         width: 100.w,
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Container(
//             height: 100.h,
//             width: 95.w,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                               width: 95.w,
//                     decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).cardTheme.color),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: widget.type==PostType.USERPOSTS? Personal(context):Explore(context),
//                     ),
//                             ),
//                 ),
//                   Expanded(child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child:widget.type==PostType.USERPOSTS? UserContentWidget(context):ExploreContentWidget(context),
//                   ))
                
//               ],
             
//             ),
//           ),
//         ),
//       ),
//     ));
//   }

  
// }