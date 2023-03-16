import 'package:blogpost/utils/api.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sizer/sizer.dart';

import '../../Modals/CommentModal.dart';

class ResponseScreen extends StatefulWidget {
  ResponseScreen({super.key,required this.postId});
  int postId;
  @override
  State<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  late Future<CommentsListDTO> futureComments;

  List<CommentData> comments=[];
  TextEditingController commentEditingController=TextEditingController();
  FocusNode commentFocusNode=FocusNode();

  @override
  void initState()
  {
    super.initState();
    futureComments=getComments();
  }

  Future<CommentsListDTO> getComments()
  {
    API api=API();
    return api.getComments(postId:widget.postId);
  }
  @override
  Widget build(BuildContext context) {
    
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title:Text('Responses'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0.0,
     
      ),
      body: FutureBuilder(future: futureComments,builder: (context,snapshot){
        if(snapshot.hasData)
             {comments=snapshot.data!.data!;
          return Container(
             height: height,
        width: width,
            child: LayoutBuilder(
              builder: (context,constraints) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(maxHeight:constraints.maxHeight*0.9),
                        width: constraints.maxWidth,
                        child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        //shrinkWrap: true,
                        itemCount: comments.length,
                        //addRepaintBoundaries: false,
                        //separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20,),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 4.0),
                            child: Container(
                              decoration: BoxDecoration(color: Theme.of(context).cardTheme.color,borderRadius: BorderRadius.circular(10)),
                              constraints: BoxConstraints(minHeight:constraints.maxHeight*0.1),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                
                                ListTile(
                                  title: Text("${comments[index].firstname} ${comments[index].lastname}",style:Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14.sp)),
                                  subtitle: Text("${comments[index].date}",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w200)),
                                ),
                                SizedBox(height:5,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Text('${comments[index].content}',style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12.sp)),
                                  ),
                                )
                                                
                              ]),
                            ),
                          );
                        },
                                            ),
                      ),
                    ),
                   
                    Container(
                     
                      constraints: BoxConstraints(minHeight: constraints.maxHeight*0.1,
                                    ),
                                    width: width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                        child: TextField(
                          onTapOutside: ((event) => commentFocusNode.unfocus()),
                          focusNode: commentFocusNode,
                          scrollPhysics: BouncingScrollPhysics(),
                          clipBehavior: Clip.none,
                          minLines: 1,
                          maxLines:5,
                          controller: commentEditingController,
                          cursorColor: Colors.green,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400
                          ),
                          decoration: InputDecoration(border: InputBorder.none,hintText: 'What are your thoughts?',suffixIcon: IconButton(onPressed: (){
                            String s=commentEditingController.text;
                            if(commentEditingController.text.trim().isNotEmpty)
                            {
                              postComment(commentEditingController.text,widget.postId);
                            }
                          }, icon: Icon(Icons.send)),suffixIconColor: Colors.green),
                                              
                        ),
                      ),
                    )
                  ],
                );
              }
            ),
          );}
else
{
  return Shimmer(direction: ShimmerDirection.fromLeftToRight(),
  color: Colors.grey,
  child: Container(
      decoration: BoxDecoration(color: Theme.of(context).cardTheme.color),
      height:height*9,
      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        //shrinkWrap: true,
                        itemCount: 8,
                        //addRepaintBoundaries: false,
                        //separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20,),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 4.0),
                            child: Container(
                              decoration: BoxDecoration(color: Theme.of(context).cardTheme.color,borderRadius: BorderRadius.circular(10)),
                              constraints: BoxConstraints(minHeight:5.h),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                
                                ListTile(
                                  title: Text("",style:Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14.sp)),
                                  subtitle: Text("",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w200)),
                                ),
                                SizedBox(height:5,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Text('',style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12.sp)),
                                  ),
                                )
                                                
                              ]),
                            ),
                          );
                        },
                                            )
    ));
}
      }),
    ));
  }

  Future postComment(String text,int postId)async
  {
    Comment comment=await API().postComment(postId: postId, text: text);

      if(comment.success!)
      setState(() {
        commentFocusNode.unfocus();
        comments.add(comment.data!);
        
      });
  }
}