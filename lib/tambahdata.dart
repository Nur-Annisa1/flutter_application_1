import 'package:flutter/material.dart';
import 'package:flutter_application_1/Adminpage.dart';
import 'package:http/http.dart' as http;

class TambahData extends StatefulWidget {
  @override
  _TambahDataState createState() => new _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  TextEditingController controllerKode = new TextEditingController();
  TextEditingController controllerNama = new TextEditingController();
  TextEditingController controllerHarga = new TextEditingController();
  TextEditingController controllerStok = new TextEditingController();

  void TambahData() {
    var url = Uri.parse("http://localhost/toko/tambahdata.php");

    http.post(url, body: {
      "kode_item": controllerKode.text,
      "nama_item": controllerNama.text,
      "harga": controllerHarga.text,
      "stok": controllerStok.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromARGB(255, 0, 25, 251),
        title: new Text("Tambah Data"),
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
            child: Container(
              color: Colors.white.withOpacity(0.7), // Ganti dengan warna latar yang diinginkan
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  new TextField(
                    controller: controllerKode,
                    decoration: new InputDecoration(
                        hintText: "Kode Item", labelText: "Kode Item"),
                  ),
                  new TextField(
                    controller: controllerNama,
                    decoration: new InputDecoration(
                        hintText: "Nama Item", labelText: "Nama Item"),
                  ),
                  new TextField(
                    controller: controllerHarga,
                    decoration: new InputDecoration(
                        hintText: "Harga", labelText: "Harga"),
                  ),
                  new TextField(
                    controller: controllerStok,
                    decoration:
                        new InputDecoration(hintText: "Stok", labelText: "Stok"),
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                  ),
                  new MaterialButton(
                    child: new Text("Tambah Data"),
                    color: Color.fromARGB(255, 0, 136, 255),
                    onPressed: () {
                      TambahData();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      setState(() {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Admin(),
                          ),
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
