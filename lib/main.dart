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

  Map<String,String> order;
  SharedPreferences prefs;

  Future<String> getData() async{
    prefs = await SharedPreferences.getInstance();
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept" : "application/json"
      }
    );


    this.setState(()  {
      this.cafeteria = new SplayTreeMap<String,dynamic>.from(json.decode(response.body), (a,b)  =>  _compare(a,b));
    //  this.cafeteria = new Map<String,dynamic>.  .from(json.decode(response.body));
    //  print(cafeteria.toString());
    });

    return json.decode(response.body);
  }
  int _compare(String a,String b) {
    var locB = _orderFoodLocationTime(b);
    var locA = _orderFoodLocationTime(a);
    if(locB - locA == 0){
      return 1;
    }
    return _orderFoodLocationTime(b) - _orderFoodLocationTime(a);
  }


   int _orderFoodLocationTime(String location){
      var time = prefs.getInt(location);
      if (time == null) {
        return 0;
      }
      return time;
  }




  @override
  void initState(){
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