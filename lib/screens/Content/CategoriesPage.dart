import 'dart:developer';

import 'package:blogpost/screens/Content/AddCategories/AllCategories.dart';
import 'package:blogpost/screens/Content/UserPosts.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sizer/sizer.dart';

import '../../Modals/CategoriesModal.dart';
import '../../utils/api.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> with AutomaticKeepAliveClientMixin{

 late Future<CategoriesModal> futurecategories;
List<Category> categories=[];
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

@override
void initState() {
  super.initState();
  futurecategories = getUserCategories();
}

Future<CategoriesModal> getUserCategories()
{
  API api=new API();
  return api.getUserCategories();
}
void _onRefresh() async{
    // monitor network fetch

    futurecategories= getUserCategories();
    Future.wait([futurecategories]).then((value) =>
    setState(()
        {
    categories=value[0].data!;}));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
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
              
              actions: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(onPressed: (){
                 var result= Get.to(()=>AddCategories());
                 //log("result is $result");
                //  if(result==true)
                //  {
                    
                //  log("result is $result");
                //   setState(() {
                //     categories=getUserCategories();
                //   });}
                    
                }, icon: Icon(LineIcons.plus,size: 4.h,)),
              )],
              pinned: true,
              automaticallyImplyLeading: false,
          expandedHeight: height*0.2,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            title: Text('Your Topics', textScaleFactor: 1,style: TextStyle(color:Theme.of(context).textTheme.headlineLarge!.color ),),
            
            
          
            // background: Image.asset(
            //   'assets/register.jpg',
            //   fit: BoxFit.fill,
            // ),
          ),
      
        ),
         FutureBuilder(
            future: futurecategories
            ,builder: ((context, snapshot) {
            if(snapshot.hasData)
            {
              categories=snapshot.data!.data!;
              if(categories.length>0)
              return SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
              
                return Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 2.0),
                      child: Container(
                          decoration:BoxDecoration(/*gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: colorListStudent[index%4],
                          )*/color: Theme.of(context).cardTheme.color,borderRadius: BorderRadius.circular(2),/*border: Border.all(width: 5,color: Colors.black)*/),
                          height: 12.h,
                          width: 85.w,
                          child:Material(
                            color: Colors.white.withOpacity(0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2)),
                            child: InkWell(
                              borderRadius:BorderRadius.circular(2) ,
                              onTap: ()
                              {
        
                              },
                              splashFactory: InkRipple.splashFactory,
                              enableFeedback: false,
                              excludeFromSemantics: false,
                              splashColor: Colors.white38,
                              focusColor: Colors.grey.shade300,
                              //highlightColor: Colors.grey.shade300,
                              child: Center(
                                child: ListTile(
                                title: Text('${categories[index].categoryTitle}',maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium,),
                                subtitle: Text('${categories[index].categoryDescription}',maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w200)),
                                trailing: ElevatedButton(onPressed: () {  },
                                child: Text('Unsubscribe'),style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900,foregroundColor: Colors.white),),),
                              )
                            ),
                          )
                      ),
                    );
              },
              childCount: categories.length,
            ),
          );
          else
         return SliverToBoxAdapter
         (child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: EmptyListWidget(message: "You have not subscribed to any topics."),
         ));
            }
            else
            {
              return SliverToBoxAdapter(child: ShimmerLoadingWidget());
            }
          })),
          ]
        ),
      ),
    ));
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}