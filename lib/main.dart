import 'screen/add.dart';
import 'screen/view.dart';
import 'screen/upload.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
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
              'Add new file:',
            ),

            new IconButton(icon: new Icon(Icons.add), onPressed: (){
              Navigator.push(context, new MaterialPageRoute(builder: (context)=> new AddPage(title: "add page",)));
            }),

            new Text(
              'View file:',
            ),

            new IconButton(icon: new Icon(Icons.view_carousel), onPressed: (){
              Navigator.push(context, new MaterialPageRoute(builder: (context)=> new ViewPage(title: "view page",)));
            }),
            new Text(
              'upload file:',
            ),

            new IconButton(icon: new Icon(Icons.file_upload), onPressed: (){

              toUoloadFile();
            }),




          ],
        ),
      ),
    );
  }

  void toUoloadFile() async{
    final FirebaseApp app = await FirebaseApp.configure(
      name: 'muza',
      options: new FirebaseOptions(
        googleAppID: Platform.isIOS
            ? '1:143496457300:ios:52f19d63cc363202'
            : '1:143496457300:android:52f19d63cc363202',
        gcmSenderID: '143496457300',
        apiKey: 'AIzaSyAVakTN1piftM1PCcshpDAMLyFPNJg1O3I',
        projectID: 'university-77101',
      ),
    );

    final FirebaseStorage storage = new FirebaseStorage(app: app, storageBucket: 'gs://university-77101.appspot.com');
    Navigator.push(context, new MaterialPageRoute(builder: (context)=> new UploadPage(storage: storage)));
  }
}
