import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sizer/sizer.dart';

import '../../../Modals/AllPostsModal.dart';
import '../../../utils/colors.dart';

class PostsListWidget extends StatefulWidget {
  PostsListWidget({
    super.key,required this.posts,required this.function
  });
  List<Content> posts;
   Function function;
  @override
  State<PostsListWidget> createState() => _PostsListWidgetState();
}

class _PostsListWidgetState extends State<PostsListWidget> {
  
  @override
  Widget build(BuildContext context) {
    print("Length of posts ${widget.posts.length}");
    var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
    return SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, int index) {
          
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 2.0),
          child: Neumorphic(
            style: NeumorphicStyle(
          depth: 2,
          lightSource: LightSource.topLeft,
          color: Colors.white,
          shadowDarkColor: Colors.white10,//Color(0xFF272626),
          shadowLightColor: Colors.grey,//Color(0xFF6f6c6c),
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(
    BorderRadius.circular(12),
          ),
          // border: NeumorphicBorder()
        ),
            child: Container(
                decoration:BoxDecoration(gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: !isDarkMode?colorListStudent[index%4]:colorListDarkMode[index%4],
                )/*borderRadius: BorderRadius.circular(20),border: Border.all(width: 5,color: Colors.black)*/),
                height: 15.h,
                width: 85.w,
                child:Material(
                  color: Colors.white.withOpacity(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    borderRadius:BorderRadius.circular(10) ,
            
                    splashFactory: InkRipple.splashFactory,
                    enableFeedback: false,
                    excludeFromSemantics: false,
                    splashColor: Colors.white38,
                    focusColor: Colors.grey.shade300,
                    //highlightColor: Colors.grey.shade300,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                               Text('$index  ${widget.posts[index].user!.firstname!} ${widget.posts[index].user!.lastname!} in ${widget.posts[index].category!.categoryTitle!}'),
                               Text(widget.posts[index].content!),
                               Text('${widget.posts[index].addedDate!}')
                          ,                             Row(),
                                    
                                    
                              ],
                            ),
                          ),
                          Expanded
                          (flex: 1,
                            child: Container(
                              height: 8.h,
                              width: 20.w,
                              child: widget.posts[index].imageUrl!=null?CachedNetworkImage(placeholder:((context, url) => Image.asset('assets/no_image.jpg')) ,imageUrl: '${widget.posts[index].imageUrl}?si=Client%20Read&spr=https&sv=2021-06-08&sr=c&sig=Ph0eekL09Jv82offqeob14Lyhg7oZNI611YPmKjsx5g%3D'):Image.asset('assets/no_image.jpg'),
                            ),
                          )
                        ],
                      ),
                    ),/*ListTile(isThreeLine: true,title: Text(widget.posts[index].title!),
                    subtitle: Text(widget.posts[index].content!,overflow: TextOverflow.ellipsis,),
                    )*/ 

                  ),
                )
            ),
          ),
        );
          },
          childCount: widget.posts.length,
        ),
      );
  }
}