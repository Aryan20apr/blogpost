import 'dart:math';

import 'package:blogpost/providers/RefreshProvider.dart';
import 'package:blogpost/screens/Content/Post/CompletePost.dart';
import 'package:blogpost/screens/NavPage.dart';
import 'package:blogpost/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../Modals/UserPostsModal.dart';
import '../../utils/api.dart';

class UserPosts extends StatefulWidget {
  const UserPosts({super.key});

  @override
  State<UserPosts> createState() => UserPostsState();
}

class UserPostsState extends State<UserPosts> with AutomaticKeepAliveClientMixin {

  late Future<UserPostsModal> futureposts;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
   List<UserPostData> posts=[];

   

  @override
  void initState()
  {
    super.initState();
    futureposts=getPosts();
  }

  Future<UserPostsModal> getPosts()async
  {
   
    
    return API().getUserPosts();

  }

  void _onRefresh() async{
    // monitor network fetch

    futureposts= API().getUserPosts();
    Future.wait([futureposts]).then((value) =>
    setState(()
        {
    posts=value[0].data!;}));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return SafeArea(child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //appBar: AppBar(title: Text('Home')),
      body: SmartRefresher(
        onRefresh: _onRefresh,
        enablePullDown: true,controller: _refreshController,
        header: WaterDropMaterialHeader(color:Colors.blueAccent,backgroundColor: Colors.white,),
        child: CustomScrollView(
          slivers:<Widget>[
             SliverAppBar(
          expandedHeight: height*0.2,
          flexibleSpace: FlexibleSpaceBar(
            
            title: Text('Your Posts', textScaleFactor: 1,style: TextStyle(color:Theme.of(context).textTheme.headlineLarge!.color ),),
            
          
            // background: Image.asset(
            //   'assets/register.jpg',
            //   fit: BoxFit.fill,
            // ),
          ),
      
        ),
      
         FutureBuilder(future: futureposts,builder: (context, snapshot){
            if(snapshot.hasData)
            {
              List<UserPostData> posts=snapshot.data!.data!;
              
              return posts.isNotEmpty?PostsListWidget(posts: posts,function: _onRefresh,):SliverToBoxAdapter(child: EmptyListWidget(message: "You don\'t have any posts yet.",));
            }
            else{
              return  SliverToBoxAdapter(child: LoadingWidget());
            }
      
         })
          ]
        ),
        
      ),
    ));
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class EmptyListWidget extends StatelessWidget {
   EmptyListWidget({
    super.key,required this.message
  });
  String message;
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Text('$message',style: TextStyle(color: Colors.grey,fontSize: 14.sp,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
      
    );
  }
}

class PostsListWidget extends StatefulWidget {
  PostsListWidget({
    super.key,required this.posts,required this.function
  });
  List<UserPostData> posts;
   Function function;
  @override
  State<PostsListWidget> createState() => _PostsListWidgetState();
}

class _PostsListWidgetState extends State<PostsListWidget> {
  
  @override
  Widget build(BuildContext context) {
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
                    onTap: ()async
                    {
                bool b=   await  Get.to(()=>Post(post: widget.posts[index]));
                    // RefreshProvider provider=Provider.of<RefreshProvider>(context,listen: false);
                      print('b=$b');
                     if(b)
                     
                      widget.function();
                     
                    },
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
                               Text('You in ${widget.posts[index].category!.categoryTitle!}'),
                               Text(widget.posts[index].title!),
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
