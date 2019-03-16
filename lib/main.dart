import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'newsResponse.dart';
import 'article.dart';
import 'detailScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
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
  NewsResponse newsResponse;
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
      newsResponse =  NewsResponse.fromJson(jsonResponse);
      setState(() {
        articles = newsResponse.articles;
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

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar:  AppBar(
          title:  Text(widget.title),
        ),
        body:  ListView.builder(
          itemCount: articles == null ? 0 : articles.length,
          itemBuilder: (BuildContext context, int index) {
            return  Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child:   ListTile(

                  title:  Text(  articles[index].title == null ? ""
                      : articles[index].title,style: TextStyle(fontFamily: "Lato",fontSize:18)),
                  onTap: () {
                    Navigator.push(
                        context,
                         MaterialPageRoute(
                            builder: (context) =>
                                 NewsDetail(articles: articles[index])));
                  },
                  subtitle:  Text(articles[index].publishedAt == null
                      ? ""
                      : articles[index].publishedAt),
                  leading:  Container( color: Colors.greenAccent, height:70.0,width: 100.0 , child: new Image.network(
                      articles[index].urlToImage == null
                          ? ""
                          : articles[index].urlToImage,
                      fit: BoxFit.cover)) ,
                ));
          },
        ));
  }
}
