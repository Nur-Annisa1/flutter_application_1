import 'package:flutter/material.dart';
import './editdata.dart';
import 'package:flutter_application_1/Adminpage.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({super.key, required this.index, required this.list});
  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {
  void DeleteData() {
    var url = Uri.parse("http://localhost/toko/deletedata.php");

    http.post(url, body: {
      'id': widget.list[widget.index]['id'],
    });
  }

 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromARGB(255, 58, 52, 247),
          title: new Text("${widget.list[widget.index]['nama_item']}")),
      body: new Container(
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(children: <Widget>[
              new Text(
                widget.list[widget.index]['nama_item'],
                style: new TextStyle(fontSize: 20.0),
              ),
              new Text(
                "Kode Item : ${widget.list[widget.index]['kode_item']}",
                style: new TextStyle(fontSize: 18.0),
              ),
              new Text(
                "Harga : ${widget.list[widget.index]['harga']}",
                style: new TextStyle(fontSize: 18.0),
              ),
              new Text(
                "Stok: ${widget.list[widget.index]['stok']}",
                style: new TextStyle(fontSize: 18.0),
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 30.0),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
