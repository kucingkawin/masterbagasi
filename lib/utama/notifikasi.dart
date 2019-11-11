import 'package:flutter/material.dart';

class Notifikasi extends StatefulWidget {
  Notifikasi({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _NotifikasiState createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      itemBuilder: (context, index){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.shopping_cart, size: 50.0),
              SizedBox(width: 10.0),
              Expanded(child: Text('Ada notifikasi.'))
            ]
          )
        );
      },
      itemCount: 10
    );
  }

}