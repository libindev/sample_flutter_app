import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'newsResponse.dart';
import 'article.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'News Api'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
      NewsResponse  newsResponse;
      List<Articles> articles;

  fetchJSON() async {
    var Response = await http.get(
      "https://newsapi.org/v2/top-headlines?sources=google-news&apiKey=bde8575cee934528b694b97ee85ab245",
      headers: {"Accept": "application/json"},
    );

    if (Response.statusCode == 200) {
      String responseBody = Response.body;
      String jsonString = responseBody;
      final jsonResponse = json.decode(jsonString);
      newsResponse = new NewsResponse.fromJson(jsonResponse);
      setState(() {

        articles=newsResponse.articles;
      // print(newsResponse.articles[0].description);
      });
    } else {
      print('Something went wrong. \nResponse Code : ${Response.statusCode}');
    }
  }

  @override
  void initState() {
    fetchJSON();
  }


      Widget _buildProductItem(BuildContext context, int index) {
        return  new Card(
          child:new Column(
            children: <Widget>[
            new  Text(newsResponse.articles[index].description, style:new TextStyle(color: Colors.deepPurple))
            ],
          ),
        );
      }



  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(

        title: new Text(widget.title),
      ),
      body: new ListView.builder(

    itemCount: articles == null ? 0 : articles.length,

      itemBuilder: (BuildContext context, int index) {

        return new Card(

          child: new InkWell(child:new Container(child: new Row(
            children: <Widget>[ new  Column(
              children: <Widget>[new Image.network(articles[index].urlToImage==null?"https://picsum.photos/250?image=9":articles[index].urlToImage,width:100.0,height: 100.0 ,)],
            ),new Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[ new Column(children: <Widget>[
                new Text(articles[index].author==null?"":articles[index].author),
                new Text(articles[index].publishedAt==null?"":articles[index].publishedAt)
              ],)],
            )],
          )

          ) )





        );

      },

    )

    );
  }



}
