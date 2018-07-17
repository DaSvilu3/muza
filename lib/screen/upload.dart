import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class UploadPage extends StatefulWidget {
  UploadPage({this.storage});
  final FirebaseStorage storage;

  @override
  _UploadPageState createState() => new _UploadPageState();
}

const String kTestString = "Hello world!";

class _UploadPageState extends State<UploadPage> {
  String _fileContents;
  String _name;
  String _bucket;
  String _path;
  String _tempFileContents;

  Future<Null> _uploadFile() async {
    final Directory systemTempDir = Directory.systemTemp;
    final File file = await new File('${systemTempDir.path}/foo.txt').create();
    file.writeAsString(kTestString);
    assert(await file.readAsString() == kTestString);
    final String rand = "${new Random().nextInt(10000)}";
    final StorageReference ref =
    widget.storage.ref().child('text').child('foo$rand.txt');
    final StorageUploadTask uploadTask = ref.putFile(
      file,
      new StorageMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{'activity': 'test'},
      ),
    );

    final Uri downloadUrl = (await uploadTask.future).downloadUrl;
    final http.Response downloadData = await http.get(downloadUrl);
    final String name = await ref.getName();
    final String bucket = await ref.getBucket();
    final String path = await ref.getPath();
    final File tempFile = new File('${systemTempDir.path}/tmp.txt');
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
    await tempFile.create();
    assert(await tempFile.readAsString() == "");
    final StorageFileDownloadTask task = ref.writeToFile(tempFile);
    final int byteCount = (await task.future).totalByteCount;
    final String tempFileContents = await tempFile.readAsString();
    assert(tempFileContents == kTestString);
    assert(byteCount == kTestString.length);

    setState(() {
      _fileContents = downloadData.body;
      _name = name;
      _path = path;
      _bucket = bucket;
      _tempFileContents = tempFileContents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Flutter Storage Example'),
      ),
      body: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _fileContents == null
                ? const Text('Press the button to upload a file \n '
                'and download its contents to tmp.txt')
                : new Text(
              'Success!\n Uploaded $_name \n to bucket: $_bucket\n '
                  'at path: $_path \n\nFile contents: "$_fileContents" \n'
                  'Wrote "$_tempFileContents" to tmp.txt',
              style: const TextStyle(
                  color: const Color.fromARGB(255, 0, 155, 0)),
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _uploadFile,
        tooltip: 'Upload',
        child: const Icon(Icons.file_upload),
      ),
    );
  }
}