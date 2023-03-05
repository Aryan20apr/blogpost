import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../Modals/AllPostsModal.dart';
import '../../Modals/UserPostsModal.dart';
import '../../utils/api.dart';
import '../../utils/colors.dart';
import '../NavPage.dart';
import 'Post/CompletePost.dart';
import 'Post/PostListWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
   

 late Future<AllPostsModal> futureposts;
 late int _totalPages;
 int _currentPage=0;


  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
   List<Content> posts=[];

   

  @override
  void initState()
  {
    super.initState();
    futureposts=getAllPosts(pageNumber: 0);
  }

  Future<AllPostsModal> getAllPosts({required int pageNumber})async
  {
   
    
    return API().getAllPosts(pageNumber: pageNumber);

  }

  void _onRefresh() async{
    // monitor network fetch
    
    
    futureposts= API().getAllPosts(pageNumber: 0);
    Future.wait([futureposts]).then((value) =>
    setState(()
        {
    posts=value[0].data!.content!;
    _totalPages=value[0].data!.totalPages!;
    _currentPage=0;}));
    
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }
   void _onLoading() async{
    
    // monitor network fetch
    log("In _onLoading");
      if(_currentPage+1<_totalPages)
      
    {log("In currentpage+1 <total pages");
      futureposts= API().getAllPosts(pageNumber: _currentPage+1);
    Future.wait([futureposts]).then((value) =>
    setState(()
        {
          _currentPage++;
    posts.addAll( value[0].data!.content!);}));
    log('Size of post=${posts.length}');
    // if failed,use refreshFailed()
    _refreshController.loadComplete();
    
    }
    else
    {log("No More Data");
    setState(()
    {
    _refreshController.loadNoData();});}
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
        onLoading: _onLoading,
       
        enablePullUp: true,
        enablePullDown: true,controller: _refreshController,
        header: WaterDropMaterialHeader(color:Colors.blueAccent,backgroundColor: Colors.white,),
        footer: CustomFooter(
          builder: ( context, mode){
            Widget body ;
            log("Mode is $mode");
            if(mode==LoadStatus.idle){
              
              body =  Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  CircularProgressIndicator.adaptive();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
                body = Text("release to load more");
            }
            else{
              body = Text("You have reached end of list.");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        child: CustomScrollView(
          slivers:<Widget>[
             SliverAppBar(
          expandedHeight: height*0.2,
          flexibleSpace: FlexibleSpaceBar(
            
            title: Text('Explore', textScaleFactor: 1,style: TextStyle(color:Theme.of(context).textTheme.headlineLarge!.color ),),
            
          
            // background: Image.asset(
            //   'assets/register.jpg',
            //   fit: BoxFit.fill,
            // ),
          ),
      
        ),
      
         FutureBuilder(future: futureposts,builder: (context, snapshot){
            if(snapshot.hasData)
            {
              _totalPages=snapshot.data!.data!.totalPages!;
              _currentPage=snapshot.data!.data!.pageNumber!;
              if(posts.length==0)
            posts=snapshot.data!.data!.content!;
              log("Posts assigned");
              return posts.isNotEmpty?PostsListWidget(posts: posts):SliverToBoxAdapter(child: EmptyListWidget(message: "You don\'t have any posts yet.",));
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

