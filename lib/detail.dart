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

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Apakah Anda yakin ingin menghapus '${widget.list[widget.index]['nama_item']}'"),
      actions: <Widget>[
        new MaterialButton(
          child: new Text("Delete"),
          color: Colors.red,
          onPressed: () {
            DeleteData();
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Admin(),
            ));
          },
        ),
        new MaterialButton(
          child: new Text("Cancel"),
          color: Color.fromARGB(255, 0, 255, 81),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }

  @override
Widget build(BuildContext context) {
  return new Scaffold(
    appBar: new AppBar(
      backgroundColor: Color.fromARGB(255, 0, 25, 251),
      title: new Text("${widget.list[widget.index]['nama_item']}"),
    ),
    body: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'images/bg.jpg', // Ganti dengan path gambar saturn yang sesuai
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Card(
            child: new Center(
              child: new Column(
                children: <Widget>[
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
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new MaterialButton(
                        child: new Text("EDIT"),
                        color: Color.fromARGB(255, 0, 152, 240),
                        onPressed: () => Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new EditData(
                              list: widget.list,
                              index: widget.index,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      new MaterialButton(
                        child: new Text("DELETE"),
                        color: Colors.red,
                        onPressed: () => confirm(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 80.0,
            color: Colors.black.withOpacity(0.5), // Ubah sesuai kebutuhan
          ),
        ),
      ],
    ),
  );
}
}
