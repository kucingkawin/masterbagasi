import 'package:flutter/material.dart';
import 'package:masterbagasi/login.dart';
import 'package:masterbagasi/titipan_saya.dart';
import 'package:masterbagasi/sudah_saya_belikan.dart';

class AkunSaya extends StatefulWidget {
  AkunSaya({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _AkunSayaState createState() => _AkunSayaState();
}

class _AkunSayaState extends State<AkunSaya> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Titipan Saya'),
          subtitle: Text('Lihat apa yang saya titipkan.'),
          onTap: (){
            Navigator.of(context).pushNamed(TitipanSayaPage.route);
          }
        ),
        ListTile(
          title: Text('Sudah Saya Belikan'),
          subtitle: Text('Lihat apa yang sudah saya belikan titipannya.'),
          onTap: (){
            Navigator.of(context).pushNamed(SudahSayaBelikanPage.route);
          }
        ),
        ListTile(
          title: Text('Sign Out'),
          subtitle: Text('Lakukan sign out.'),
          onTap: (){
            Navigator.of(context).pushReplacementNamed(LoginPage.route);
          }
        )
      ],
    );
  }
}