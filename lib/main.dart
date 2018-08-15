import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'FoodLocation.dart';
void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}
class MyApp extends StatefulWidget{
  @override
  _State createState() => new _State();
}

const url = "";

class _State extends State<MyApp>{
  Map<String,dynamic> cafeteria = null;
  Future<String> getData() async{
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept" : "application/json"
      }
    );
    this.setState((){
      this.cafeteria = json.decode(response.body);
    });

    //FoodLocation foodLocation = new FoodLocation("The Vista at Shaw", cafeteria);


    // print('food place: ${cafeteria['The Vista at Shaw']['Lunch']}');
    return json.decode(response.body);
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
               // print("${cafeteria.keys.elementAt(index)}");
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