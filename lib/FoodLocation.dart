import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
class FoodLocation extends StatelessWidget{
  String _name;
  List<String> _breakfast;
  Map<String,dynamic> _breakfastMap;
  List<String> _lunch;
  Map<String,dynamic> _lunchMap;
  List<String> _dinner;
  Map<String,dynamic> _dinnerMap;
  List<String> _lateNight;
  Map<String,dynamic> _lateNightMap;
  FoodLocation(String name,Map<String,dynamic> cafeteria){
    this._name = name;
    _breakfastMap = json.decode(json.encode(cafeteria[name]["Breakfast"]));
    _lunchMap = json.decode(json.encode(cafeteria[name]["Lunch"]));
    _dinnerMap = json.decode(json.encode(cafeteria[name]["Dinner"]));
    _lateNightMap = json.decode(json.encode(cafeteria[name]["Late Night"]));


    //  Map<String,dynamic> cafeteria = json.decode(response.body);
   // print('food place: ${cafeteria['The Vista at Shaw']['Lunch']}');
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold (
        appBar: new AppBar(
          title: new Text(_name),
        ),
        body: new Column(
          children: <Widget>[
            //Breakfast, Lunch, Dinner titles
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Text('Breakfast', textAlign: TextAlign.center),
                ),
                new Expanded(
                  child: new Text('Lunch', textAlign: TextAlign.center),
                ),
                new Expanded(
                  child: new Text('Dinner', textAlign: TextAlign.center),
                ),
                new Expanded(
                  child: new Text('Late Night', textAlign: TextAlign.center),
                )
              ],
            )
            ,
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Text('Breakfast', textAlign: TextAlign.center),
                ),
                new Expanded(
                  child: new Text('Lunch', textAlign: TextAlign.center),
                ),
                new Expanded(
                  child: new Text('Dinner', textAlign: TextAlign.center),
                ),
                new Expanded(
                  child: new Text('Late Night', textAlign: TextAlign.center),
                )
              ],
            )
            ,
          ],
        )


    );
  }


}