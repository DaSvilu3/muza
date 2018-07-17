
import 'package:flutter/material.dart';
import 'package:muza_test/models/file.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class ViewPage extends StatefulWidget {
  ViewPage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _ViewPageState createState() => new _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {


  File file;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    GetItemsFromDb.getItems().then((map){

      // firebase response will be like this
      // [null, {file1: file1, name: yousuf, user: yousf}]

      for (int i=0; i < map.length; i++) {
        print(map[i]);
      }

      setState(() {
        file = new File.fromMap(map[1]);
      });


    });
  }

  @override
  Widget build(BuildContext context) {

    Widget content;

    // if the data still loading, a circular indicator will be running
    // if the data arrived, then it will display it
    if (file == null) {
      content = new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      // I can put all the layout in a function and use it multiple times
      content = _buildMainView();
    }


    /*
      THERE are 3 parts in each layout
      1- app bar (themes, titles, etc ...)
      2- body (you can put any container here )
      3- bottom navigation bar (for the tab bar, special buttons (edit, update)
     */
    return new Scaffold(
      // in app bar you can modify the themes, the bar .. etc
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: content// This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  Center _buildMainView(){
    return new Center(

      child: new Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            'Name: ' + file.name,
          ),
          new Text("user :" + file.user,
            style: Theme.of(context).textTheme.display1,
          ),

        ],
      ),
    );
  }
}


class GetItemsFromDb {
  static Future<List> getItems( ) async {
    Completer<List> completer = new Completer<List>();

    FirebaseDatabase.instance
        .reference()
        .child("files")

        .once()
        .then( (DataSnapshot snapshot) {
      //print(snapshot.value);
      List map = snapshot.value;
//      for(var v in snapshot) {
//
//      }
//      var abayah = new Abayah.fromJson(snapshot.key, snapshot.value);
      completer.complete(map);
    } );

    return completer.future;
  }
}