import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}
class MyApp extends StatefulWidget{
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp>{
  static const url = "";

  Future<String> getData() async{
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept" : "application/json"
      }
    );
    Map<String,dynamic> cafeteria = json.decode(response.body);
    print('food place: ${cafeteria['The Vista at Shaw']['Breakfast']}');

  }

  List<bool> _data = new List<bool>();
  @override
  void initState() {
    setState((){
      for(int i =0; i < 10; i++){
        _data.add(false);
      }
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Menu"),
        ),
        body: new ListView.builder(
          itemCount: _data.length,
          itemBuilder: (BuildContext context, int index){
            return new Card(
              child: new Container(
                padding: new EdgeInsets.all(32.0),
                child: new Column(
                    children: <Widget>[
                      new Text("This is item ${index}"),
                    ]
                ),
              )
            );
          },
        )
      );
  }
}