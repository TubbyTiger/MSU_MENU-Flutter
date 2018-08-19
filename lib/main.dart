import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'FoodLocation.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}
class MyApp extends StatefulWidget{
  @override
  _State createState() => new _State();
}

final url = "";

class _State extends State<MyApp>{
  SplayTreeMap<String,dynamic> cafeteria;
  Future<String> getData() async{
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept" : "application/json"
      }
    );
    this.setState((){
      this.cafeteria = new SplayTreeMap<String,dynamic>.from(json.decode(response.body));
//      this.cafeteria = new SplayTreeMap<String,dynamic>.from(json.decode(response.body), (a,b) => compare(a,b));

    });

    return json.decode(response.body);
  }



  int _compare(a,b){
    return 1;
  }


  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Menu"),
        ),
        body: new ListView.builder(
          itemCount: cafeteria == null ? 0 : cafeteria.length,
          itemBuilder: (BuildContext context, int index){
            return new GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FoodLocation(cafeteria.keys.elementAt(index),cafeteria)));
              },
              child: new Card(
                child: new Container(
                  padding: new EdgeInsets.all(32.0),
                  child: new Text(cafeteria.keys.elementAt(index))
                )
              )
            );
          },
        )
      );
  }
}