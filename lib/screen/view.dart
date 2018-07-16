
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

  String name;
  String user;
  String file1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    GetItemsFromDb.getItems().then((map){
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(

          title: new Text(widget.title),
        ),
        body: new Center(

          child: new Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'Name:',
              ),
              new TextField(
                decoration: new InputDecoration(
                    hintText: "write name",
                    labelText: "Write full name"
                ),
                onChanged: (str){
                  name = str;
                },
              ),
              new Text("user",
                style: Theme.of(context).textTheme.display1,
              ),
              new TextField(
                decoration: new InputDecoration(
                    hintText: "write user here",
                    labelText: "Write username"
                ),
                onChanged: (str){
                  user = str;
                },
              ),
            ],
          ),
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class GetItemsFromDb {
  static Future<Map> getItems( ) async {
    Completer<Map> completer = new Completer<Map>();

    FirebaseDatabase.instance
        .reference()
        .child("files")

        .once()
        .then( (DataSnapshot snapshot) {

      Map map = snapshot.value;
//      for(var v in snapshot) {
//
//      }
//      var abayah = new Abayah.fromJson(snapshot.key, snapshot.value);
      completer.complete(map);
    } );

    return completer.future;
  }
}