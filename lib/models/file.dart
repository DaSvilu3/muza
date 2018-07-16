
class File {


  String name;
  String user;
  String file1;
  List<String> links;


  File.fromMap(Map map) {

    name = map["name"];
    user = map["user"];
    file1 = map["file1"];

  }

}