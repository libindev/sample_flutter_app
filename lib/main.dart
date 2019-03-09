import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'NewsResponse.dart';

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
      NewsResponse  newsResponse ;

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
        print(newsResponse.articles[0].description);
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

    return new Scaffold(
      appBar: new AppBar(

        title: new Text(widget.title),
      ),
      body: new Center()
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



}
