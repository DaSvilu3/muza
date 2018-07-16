
import 'package:flutter/material.dart';
import 'package:muza_test/models/file.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _AddPageState createState() => new _AddPageState();
}

class _AddPageState extends State<AddPage> {


  File file;

  String name;
  String user;
  String file1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


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
