import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masterbagasi/admin/beranda.dart';
import 'package:masterbagasi/admin/titipan.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key key, this.title}) : super(key: key);

  static String route = 'admin';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  TextEditingController _controllerPencarian = TextEditingController();
  int _bottomNavCurrentIndex = 0;

  @override
  void initState() {

  }

  Widget _title()
  {
    if(_bottomNavCurrentIndex == 0)
      return Text('Masterbagasi (Admin)');
    else if (_bottomNavCurrentIndex == 1)
      return Text('Titipan');
    else if (_bottomNavCurrentIndex == 2)
      return Text('Notifikasi');
    else if (_bottomNavCurrentIndex == 3)
      return Text('Akun Saya');
  }

  Widget _bottomNavigationMenuUtama()
  {
    return new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _bottomNavCurrentIndex = index;
        });
      },
      currentIndex: _bottomNavCurrentIndex,
      items: [
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.home,
            color: Theme.of(context).appBarTheme.color,
          ),
          icon: new Icon(
            Icons.home,
            color: Theme.of(context).appBarTheme.color,
          ),
          title: new Text(
            'Beranda',
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.shopping_cart,
            color: Theme.of(context).appBarTheme.color,
          ),
          icon: new Icon(
            Icons.shopping_cart,
            color: Colors.grey,
          ),
          title: new Text('Titipan'),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.notifications,
            color: Theme.of(context).appBarTheme.color,
          ),
          icon: new Icon(
            Icons.notifications,
            color: Colors.grey,
          ),
          title: new Text('Notifikasi'),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.account_circle,
            color: Theme.of(context).appBarTheme.color,
          ),
          icon: new Icon(
            Icons.account_circle,
            color: Colors.grey,
          ),
          title: new Text('Akun Saya'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    TextField teksPencarian = TextField(
      controller: _controllerPencarian,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Mencari apa?',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            style: BorderStyle.none
          )
        ),
        filled: true,
        fillColor: Colors.white
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: IndexedStack(
        index: _bottomNavCurrentIndex,
        children: <Widget>[
          Beranda(),
          Titipan(),
          Container(),
          Container(),
        ]
      ),
      bottomNavigationBar: _bottomNavigationMenuUtama(),
    );
  }
}

