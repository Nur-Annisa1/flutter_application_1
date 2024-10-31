import 'package:flutter/material.dart';
import 'package:flutter_application_1/Adminpage.dart';
import 'package:http/http.dart' as http;

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({super.key, required this.list, required this.index});

  @override
  _EditDataState createState() => new _EditDataState();
}

class _EditDataState extends State<EditData> {
  late TextEditingController controllerKode;
  late TextEditingController controllerNama;
  late TextEditingController controllerHarga;
  late TextEditingController controllerStok;

  void EditData() {
    var url = Uri.parse("http://localhost/toko/editdata.php");

    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "kode_item": controllerKode.text,
      "nama_item": controllerNama.text,
      "harga": controllerHarga.text,
      "stok": controllerStok.text,
    });
  }

  @override
  void initState() {
    controllerKode =
        new TextEditingController(text: widget.list[widget.index]['kode_item']);
    controllerNama =
        new TextEditingController(text: widget.list[widget.index]['nama_item']);
    controllerHarga =
        new TextEditingController(text: widget.list[widget.index]['harga']);
    controllerStok =
        new TextEditingController(text: widget.list[widget.index]['stok']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromARGB(255, 0, 25, 251),
        title: new Text("Edit Data"),
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
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    buildTextField("Kode Item", controllerKode),
                    buildTextField("Nama Item", controllerNama),
                    buildTextField("Harga", controllerHarga),
                    buildTextField("Stok", controllerStok),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                    ),
                    new MaterialButton(
                      child: new Text("OK"),
                      color: Color.fromARGB(255, 60, 240, 84),
                      onPressed: () {
                        EditData();
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new Admin(),
                          ),
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: labelText,
            labelText: labelText,
            contentPadding: EdgeInsets.all(16),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
