import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class FoodLocation extends StatefulWidget{

  @override
  _MyTabbedPageState createState() => new _MyTabbedPageState(_meals,_name);

  Map<String,dynamic> _meals;
  String _name;
  FoodLocation(String name,Map<String,dynamic> cafeteria){
    this._name = name;
    _meals = cafeteria[_name];
  }
}

class _MyTabbedPageState extends State<FoodLocation> with SingleTickerProviderStateMixin{

 List<Tab> _myTabs = new List<Tab>();
  String _name;
  TabController _tabController;
  //Comparator function
   int _compare(String a, String b){
     List<String> order = ["Breakfast","Lunch","Dinner","Late Night"];
     return order.indexOf(a) - order.indexOf(b);
   }

  _MyTabbedPageState(Map<String,dynamic> meals,String name){
    this._meals = meals;
    this._name = name;
    _addName();
    List<String> mealTimes = meals.keys.toList();
    mealTimes.sort((a, b) => _compare(a,b));
    for(String mealTime in mealTimes){
      _myTabs.add(new Tab(text: mealTime));
    }
  }

  _addName() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var time = new DateTime.now().millisecondsSinceEpoch;
     print("$_name clicked on time: $time");
     await prefs.setInt(_name, time);
  }

  Map<String,dynamic> _meals;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: _myTabs.length);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getMeals(String mealTime){
    String display = "";
    Map<String,dynamic> meal = json.decode(json.encode(_meals[mealTime]));
    for(String mealPlace in meal.keys){
      display += mealPlace + "\n";
      display += meal[mealPlace].toString() + "\n\n\n";
    }
    return display;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_name),
        bottom: new TabBar(
          controller: _tabController,
          tabs: _myTabs,
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: _myTabs.map((Tab tab) {
          return new Center(child: new SingleChildScrollView(
            child: new Text(_getMeals(tab.text)),
          ));
        }).toList(),
      ),
    );
  }
}