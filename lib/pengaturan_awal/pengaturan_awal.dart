import 'package:flutter/material.dart';
import 'package:masterbagasi/pengaturan_awal/bagian/awal.dart';
import 'package:masterbagasi/pengaturan_awal/bagian/pilih_destinasi.dart';

class PengaturanAwalPage extends StatefulWidget {
  PengaturanAwalPage({Key key, this.title}) : super(key: key);

  static _PengaturanAwalPageState of(BuildContext context)
  {
    return context.ancestorStateOfType(TypeMatcher<_PengaturanAwalPageState>());
  }

  static String route = 'pengaturan-awal';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _PengaturanAwalPageState createState() => _PengaturanAwalPageState();
}

class _PengaturanAwalPageState extends State<PengaturanAwalPage> {

  int _indeksPage;

  @override
  void initState()
  {
    _indeksPage = 0;
  }

  void berikutnya()
  {
    setState((){
      _indeksPage += 1;
    });
  }

  void sebelumnya()
  {
    setState((){
      _indeksPage -= 1;
    });
  }

  Color _warnaLatarBelakang(BuildContext context)
  {
    if(_indeksPage == 0)
      return Colors.blue;
    else if(_indeksPage == 1)
      return Theme.of(context).scaffoldBackgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    ThemeData themeData = Theme.of(context).copyWith(
      accentColor: Colors.white,
    );

    return Theme(
      data: themeData,
      child: Scaffold(
        backgroundColor: _warnaLatarBelakang(context),
        body: IndexedStack(
          index: _indeksPage,
          children: <Widget>[
            Awal(),
            PilihDestinasi(),
          ],
        )
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
