import 'package:flutter/material.dart';
import 'package:flutter_application_1/Adminpage.dart';
import 'package:flutter_application_1/login.dart';
import 'package:http/http.dart' as http;

class TambahDataUser extends StatefulWidget {
  @override
  _TambahDataUserState createState() => new _TambahDataUserState();
}

class _TambahDataUserState extends State<TambahDataUser> {
  TextEditingController controllerNama = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  TextEditingController controllerLevel = new TextEditingController();

  void TambahDataUser() {
    var url = Uri.parse("http://localhost/toko/tambahdatauser.php");

    http.post(url, body: {
      "username": controllerNama.text,
      "pass": controllerPassword.text,
      "lev": controllerLevel.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromARGB(255, 0, 25, 251),
        title: new Text("Tambah User"),
      ),
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'images/logo.jpg', // Replace with your image asset path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ListView(
                  children: <Widget>[
                    new TextField(
                      controller: controllerNama,
                      decoration: new InputDecoration(
                        hintText: "Username",
                        labelText: "Username",
                      ),
                    ),
                    new TextField(
                      controller: controllerPassword,
                      decoration: new InputDecoration(
                        hintText: "Password",
                        labelText: "Password",
                      ),
                    ),
                    new TextField(
                      controller: controllerLevel,
                      decoration: new InputDecoration(
                        hintText: "Admin/pengguna",
                        labelText: "Admin/pengguna",
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                    ),
                    new MaterialButton(
                      child: new Text("Tambah User"),
                      color: Color.fromARGB(255, 0, 25, 251),
                      onPressed: () {
                        TambahDataUser();
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        setState(() {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyApp(),
                            ),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
