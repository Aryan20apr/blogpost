import 'dart:developer';

import 'package:blogpost/providers/SubscriptionController.dart';
import 'package:blogpost/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sizer/sizer.dart';

import '../../../Modals/CategoriesModal.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {

late Future<CategoriesModal> categories;
late Future<CategoriesModal> usercategories;
List<int> catids=[];
List<int> uncatids=[];

@override
void initState() {
  super.initState();
  categories = getAllCategories();
  usercategories=getUserCategories();
}
Future<CategoriesModal> getUserCategories()
{
  API api=new API();
  return api.getUserCategories();
}

Future<CategoriesModal> getAllCategories()
{
  API api=new API();
  return api.getAllCategories();
}

Future<bool> onWillPop() async
{API api=API();
  if(catids.isNotEmpty)
  {
    api.subscribeCategories(catids: catids);

  }
  if(uncatids.isNotEmpty)
  {
    log("Ids to be unsubscribed $uncatids" );
    api.unsubscribeCategories(catids: uncatids);

  }

  Get.back(result:true);
  

Get.back(result:false);
return true;}

  
  @override
  Widget build(BuildContext context) {
      log("Build called");
   
        
     double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return SafeArea(child: WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
      
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        
        body: Container
        (
          height: height,
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              body:TabBarView(
                children:[New(height),Following(height),
              ]
              ),
              headerSliverBuilder:(context,value){
             return [
              
                 SliverAppBar(
                  bottom:TabBar(tabs:[Tab(child:Text("New",style: TextStyle(color:Theme.of(context).textTheme.headlineLarge!.color ))),Tab(child:Text("Following",style: TextStyle(color:Theme.of(context).textTheme.headlineLarge!.color )))]),
              expandedHeight: height*0.08,
              // flexibleSpace: FlexibleSpaceBar(
              //   title: Text('Add Topics', textScaleFactor: 1,style: TextStyle(color:Theme.of(context).textTheme.headlineLarge!.color ),
              //   ),
                
                
              //   // background: Image.asset(
              //   //   'assets/register.jpg',
              //   //   fit: BoxFit.fill,
              //   // ),
              // ),
              
                  
            ),
            
             
              ];}
            ),
          ),
        ),
      ),
    ));
  }

  FutureBuilder<CategoriesModal> Following(double height) {
    return FutureBuilder(
            future: usercategories
            ,builder: ((context, snapshot) {
            if(snapshot.hasData)
            {
              List<Category> categories=snapshot.data!.data!;
              return ListView.builder(
           
            itemBuilder: (BuildContext context, int index) {
               
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
                              child: GetX<SubscriptionController>(init: SubscriptionController(),builder:(subscriptionController)=>
                                 Center(
                                  child: ListTile(
                                  title: Text('${categories[index].categoryTitle}',maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium,),
                                  subtitle: Text('${categories[index].categoryDescription}',maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w200)),
                                  trailing: ElevatedButton(onPressed: () {
                                    if(subscriptionController.unsubscribe.contains(index))
                                    {
                                      uncatids.remove(categories[index].categoryId);
                                      //subscriptionController.isSelected.value=false;
                                       subscriptionController.removeSubscription(index);//remain subscribed
                                    }
                                    else
                
                                    {
                                      uncatids.add(categories[index].categoryId!);
                                     subscriptionController.removeSubscription(index);//unsubscribe
                                    }
                                    },
                                  child: subscriptionController.unsubscribe.contains(index)? Text('Subscribe'):Text('Unsubscribe'),style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900,foregroundColor: Colors.white),),),
                                ),
                              )
                            ),
                          )
                      ),
                    );
              },
              itemCount: categories.length, );
            }
          
            
            else
            {
              return ShimmerLoadingWidget();
            }
          }));
  }
  FutureBuilder<CategoriesModal> New(double height) {
    return FutureBuilder(
            future: categories
            ,builder: ((context, snapshot) {
            if(snapshot.hasData)
            {
              List<Category> categories=snapshot.data!.data!;
              return ListView.builder(
           
            itemBuilder: (BuildContext context, int index) {
               
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
                              child: GetX<SubscriptionController>(init: SubscriptionController(),builder:(subscriptionController)=>
                                 Center(
                                  child: ListTile(
                                  title: Text('${categories[index].categoryTitle}',maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium,),
                                  subtitle: Text('${categories[index].categoryDescription}',maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w200)),
                                  trailing: ElevatedButton(onPressed: () {
                                    if(subscriptionController.isSelected.value.contains(index))
                                    {
                                      catids.remove(categories[index].categoryId);
                                      //subscriptionController.isSelected.value=false;
                                       subscriptionController.changeSelection(index);
                                    }
                                    else
                
                                    {
                                      catids.add(categories[index].categoryId!);
                                     subscriptionController.changeSelection(index);
                                    }
                                    },
                                  child: subscriptionController.isSelected.contains(index)? Text('Unsubscribe'):Text('Subscribe'),style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900,foregroundColor: Colors.white),),),
                                ),
                              )
                            ),
                          )
                      ),
                    );
              },
              itemCount: categories.length, );
            }
          
            
            else
            {
              return ShimmerLoadingWidget();
            }
          }));
  }
}

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      color: Colors.grey,
      //highlightColor: Colors.grey[100],
      enabled: true,
      child: Container(
        height: 12.h,
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
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
                  child: ListTile(
                  title: Text('',maxLines: 2,overflow: TextOverflow.ellipsis,),
                  subtitle: Text(''),
                  trailing: ElevatedButton(onPressed: () {  },
                  child: Text(''),style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900,foregroundColor: Colors.white),),)
                ),
              )
          ),
          ),
          itemCount: 6,
        ),
      ),
    );
  }
}