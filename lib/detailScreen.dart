import 'package:flutter/material.dart';
import 'article.dart';


class NewsDetail extends StatefulWidget {

  Articles  articles;
  NewsDetail({Key key, this.articles}) : super(key: key);



  @override
  State<StatefulWidget> createState() {
    return new NewsDetailState();
  }

}


class NewsDetailState extends State<NewsDetail> {


  @override
  Widget build(BuildContext context) {
    
            return new Scaffold(
              appBar: new AppBar(
                title: new Text(widget.articles.  title),
              ),
              body: new SizedBox(  width:100.0,height:200.0 ,child: new Stack(
                fit: StackFit.expand,
                children: <Widget>[ new Image.network(widget.articles.urlToImage)],
              ))



            );
  }

}