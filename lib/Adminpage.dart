import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:http/http.dart' as http;
import './detail.dart';
import './tambahdatauser.dart';
import './tambahdata.dart';

class Admin extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Toko Handi"),
        backgroundColor: Color.fromARGB(255, 42, 1, 124),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            onSelected: (result) {
              if (result == 0) {
                Navigator.pushReplacementNamed(context, 'MyHomePage');
              } else if (result == 1) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TambahDataUser()));
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Logout'),
                value: 0,
              ),
              PopupMenuItem(
                child: Text('Tambah User'),
                value: 1,
              ),
            ],
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new TambahData()))),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/bg.jpg', 
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: new FutureBuilder<List>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? new ItemList(
                        list: snapshot.data ?? [],
                      )
                    : new Center(
                        child: new CircularProgressIndicator(),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List> getData() async {
    final response =
        await http.get(Uri.parse("http://localhost/toko/getdata.php"));
    return json.decode(response.body);
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Detail(
                      list: list,
                      index: i,
                    ))),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['nama_item']),
                leading: new Icon(Icons.widgets),
                subtitle: new Text("Stok: ${list[i]['stok']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
