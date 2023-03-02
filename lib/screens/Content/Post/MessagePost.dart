import 'package:flutter/material.dart';


class MessageArticlePage extends StatefulWidget {
  Map<String, dynamic> data;
  MessageArticlePage({required this.data});

  @override
  State<MessageArticlePage> createState() => _MessageArticlePageState();
}

class _MessageArticlePageState extends State<MessageArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Article'),
      ),
      body: Text('${widget.data}'),
    );
  }
}