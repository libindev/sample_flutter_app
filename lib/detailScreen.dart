import 'package:flutter/material.dart';
import 'article.dart';

class NewsDetail extends StatefulWidget {
  Articles articles;

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
        body: new ListView(
      shrinkWrap: true, // wrap content
      children: <Widget>[
        new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Stack(children: <Widget>[
                new Container(
                    height: 270.0,
                    child: new Image.network(widget.articles.urlToImage,
                        fit: BoxFit.fill)),
                new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                  new IconButton(

                      icon:  Icon(Icons.arrow_back),
                      color: Colors.white,
                      onPressed: () {

                        Navigator.of(context).pop();
                      }

                      ),
                  new Material(
                      elevation: 4.0,
                      borderRadius: new BorderRadius.circular(20.0),
                      child: new Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(20.0)),
                          child: new Icon(
                            Icons.favorite,
                            color: Colors.blue
                            ,
                          )))
                ])
              ]),
              new Padding(
                  padding: new EdgeInsets.all(8.0),
                  child: new Text(
                    widget.articles.title,
                    style: new TextStyle( color: Colors.black
                        , fontStyle: FontStyle.normal, fontSize: 20.0, fontFamily: "Lato"),
                  )),
              new Padding(
                  padding: new EdgeInsets.all(10.0),
                  child: new Text("   "+
                    widget.articles.description,
                    style: new TextStyle(fontSize: 18.0, fontFamily: "Lato",fontStyle: FontStyle.normal),
                  ))
            ])
      ],
    ));
  }
}
