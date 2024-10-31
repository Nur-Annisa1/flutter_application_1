import 'package:flutter/material.dart';
import 'package:flutter_application_1/Penggunapage.dart';
import 'package:flutter_application_1/Adminpage.dart';
import 'package:flutter_application_1/tambahdatauser.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toko Caca',
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        'MyHomePage': (BuildContext context) => new MyHomePage(),
        'AdminPage': (BuildContext context) => new Admin(),
        'PenggunaPage': (BuildContext context) => new Pengguna(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController username = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String message = '';

  Future<void> _login() async {
    final response =
        await http.post(Uri.parse("http://localhost/toko/login.php"), body: {
      "username": username.text,
      "pass": pass.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        message = "Login Gagal";
      });
    } else {
      if (datauser[0]['lev'] == 'admin') {
        Navigator.pushReplacementNamed(context, 'AdminPage');
      } else if (datauser[0]['lev'] == 'pengguna') {
        Navigator.pushReplacementNamed(context, 'PenggunaPage');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selamat Datang!"),
        backgroundColor: Color.fromARGB(255, 42, 1, 124),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'images/saturn.png', // Replace with the actual path to your image
              fit: BoxFit.cover,
            ),
          ),
          // Your Existing Content
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent, // Make the container transparent
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        child: Image.asset("images/caca.png"),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: username,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: pass,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    child: new Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Color.fromARGB(255, 83, 157, 243),
                    onPressed: () {
                      _login();
                    },
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TambahDataUser()),
                      );
                    },
                    child: Text(
                      "Belum Punya Akun? Daftar di sini.",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    message,
                    style: TextStyle(fontSize: 20.0, color: Colors.red),
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
