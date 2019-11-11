import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:masterbagasi/admin/admin.dart';
import 'package:masterbagasi/daftar.dart';
import 'package:masterbagasi/pengaturan_awal/pengaturan_awal.dart';
import 'package:masterbagasi/utama/utama.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  static String route = 'login';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  @override
  Widget build(BuildContext context) {

    print('Dimensi: ${MediaQuery.of(context).size.toString()}');
    print('Dimensi Sebenernya: ${MediaQuery.of(context).size * MediaQuery.of(context).devicePixelRatio}');

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0), //(left: 24.0, right: 24.0),
            controller: ScrollController(),
            shrinkWrap: true,
            children: <Widget>[
              Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 40
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              TextField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _controllerPassword,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                ),
              ),
              SizedBox(height: 20.0),
              InkWell(
                child: Text('Tidak punya akun? Daftar'),
                onTap: () => Navigator.of(context).pushNamed(DaftarPage.route)
              ),
              SizedBox(height: 10.0),
              FlatButton(
                child: Text('Login'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () async {
                  if(_controllerEmail.text == 'masterbagasi@gmail.com' && _controllerPassword.text == 'masterbagasi12345')
                    Navigator.of(context).pushReplacementNamed(AdminPage.route);
                  else if(_controllerEmail.text == 'nanda@gmail.com' && _controllerPassword.text == '123')
                    Navigator.of(context).pushReplacementNamed(PengaturanAwalPage.route);
                  else
                  {
                    AlertDialog alertDialog = AlertDialog(
                      title: Text('Kesalahan'),
                      content: Text('Email dan password tidak terdaftar.'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Baiklah'),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );

                    showDialog(context: context, builder: (context){
                      return alertDialog;
                    });
                  }
                },
              ),
            ],
          ),
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
