import 'dart:developer';
import 'dart:math';

import 'package:blogpost/screens/Content/AddCategories/AllCategories.dart';
import 'package:blogpost/screens/Content/CategoryPostsScreen.dart';
import 'package:blogpost/screens/Content/Post/PostListWidget.dart';

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

import '../../Modals/AllPostsModal.dart';
import '../../Modals/CategoriesModal.dart';
import '../../utils/api.dart';
import 'HomeScreen.dart';

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
                
                    
                }, icon: Icon(LineIcons.plus,size: 4.h,)),
              )],
              pinned: true,
              automaticallyImplyLeading: false,
          expandedHeight: height*0.2,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            title: Text('Your Topics', textScaleFactor: 1,style: TextStyle(color:Theme.of(context).textTheme.headlineLarge!.color ),),
           
          ),
      
        ),



         FutureBuilder(
            future: futurecategories
            ,builder: ((context, snapshot) {
            if(snapshot.hasData)
            {
              categories=snapshot.data!.data!;
              if(categories.length>0)
         
          return SliverGrid(delegate: SliverChildBuilderDelegate((context, index) => GridItem(category: categories[index],index: index,),childCount: categories.length), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2));
          else
         return SliverToBoxAdapter
         (child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: EmptyListWidget(message: "You have not subscribed to any topics."),
         ));
            }
            else
            {
              return SliverToBoxAdapter(child: ShimmerLoadingGridWidget());
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

class GridItem extends StatelessWidget {
   GridItem({super.key,required this.category,required this.index});
  Category category;
  int index;
  List<List<Color>> colorListAdmin=[[Colors.yellow,Colors.deepOrange],[Colors.tealAccent,Colors.greenAccent.shade400,]];
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async{
Get.showOverlay(loadingWidget: Center(child: Container(height: 0.1.h,width: 0.1.h,child: CircularProgressIndicator.adaptive())),asyncFunction: ()async
{
CategoryPosts posts=await getCategoryPosts(categoryId: category.categoryId!);
Get.to(()=>CategoryPostsScreen(posts: posts.data!,title:category.categoryTitle!));
});
         
        },
        child: Container(
          decoration: BoxDecoration(gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: colorListAdmin[0],
                        ),color: Theme.of(context).cardTheme.color,borderRadius: BorderRadius.circular(20),/*border: Border.all(width: 5,color: Colors.black)*/),
          width: width*0.4,
          height: height*0.2,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${category.categoryTitle}',maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14.sp),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${category.categoryDescription}',maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w200)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  // static getRandomColor() {
  //   return Color(Random().nextDouble() * 0xFFFFFF).toInt() << 0;
  // }).withOpacity(1.0);

    Future<CategoryPosts> getCategoryPosts({required int categoryId})async
    {
        API api=API();

      CategoryPosts allPostsModal=await api.getCategoryPosts(categoryId);

       return allPostsModal;
    }
}

class ShimmerLoadingGridWidget extends StatelessWidget {
  const ShimmerLoadingGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.height;
    return Shimmer(
      color: Colors.grey,
      //highlightColor: Colors.grey[100],
      enabled: true,
      child:Container(
          decoration: BoxDecoration(color: Theme.of(context).cardTheme.color,borderRadius: BorderRadius.circular(20),/*border: Border.all(width: 5,color: Colors.black)*/),
          width: width*0.4,
          height: height*0.2,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('',maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14.sp),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('',maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w200)),
                )
              ],
            ),
          ),
        ),
    );
  }
}