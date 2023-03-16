import 'package:blogpost/screens/Content/Post/PostListWidget.dart';
import 'package:flutter/material.dart';

import '../../Modals/AllPostsModal.dart';

class CategoryPostsScreen extends StatefulWidget {
   CategoryPostsScreen({super.key,required this.posts,required this.title});
  List<Content> posts;
  String title;

  @override
  State<CategoryPostsScreen> createState() => _CategoryPostsScreenState();
}

class _CategoryPostsScreenState extends State<CategoryPostsScreen> {
  @override
  Widget build(BuildContext context) {
    
      double height=MediaQuery.of(context).size.height;
    //double width=MediaQuery.of(context).size.width;
    return SafeArea
    (
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
           SliverAppBar(
          expandedHeight: height*0.05,
          flexibleSpace: FlexibleSpaceBar(
            
            title: Text('${widget.title}', textScaleFactor: 1,style: TextStyle(color:Theme.of(context).textTheme.headlineLarge!.color ),),
            
          
            // background: Image.asset(
            //   'assets/register.jpg',
            //   fit: BoxFit.fill,
            // ),
          ),
      
        ),
        PostsListWidget(posts:widget.posts )
          ],
        ),
    
      ),
    );
  }
}