import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masterbagasi/pengaturan_awal/pengaturan_awal.dart';
import 'package:transparent_image/transparent_image.dart';

class Awal extends StatefulWidget {
  Awal({Key key, this.title}) : super(key: key);

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
  _AwalState createState() => _AwalState();
}

class _AwalState extends State<Awal> {

  Future<void> _futureGambarJastip;

  @override
  void initState()
  {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _futureGambarJastip = precacheImage(AssetImage('assets/gambar_jastip.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return SafeArea(
      child: FutureBuilder(
        future: _futureGambarJastip,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done)
          {
            return ListView(
              controller: ScrollController(),
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset('assets/gambar_jastip.png')
                  ]
                ),
                SizedBox(height: 20.0),
                Text(
                  'Selamat Datang di Masterbagasi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Masterbagasi adalah sebuah aplikasi yang digunakan untuk melakukan proses titip barang antara 2 negara, yaitu Indonesia dan Korea Selatan.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Tekan tombol berikutnya untuk melanjutkan proses. Proses ini mungkin bisa saja memakan waktu sebentar.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0
                  ),
                ),
                SizedBox(height: 15.0),
                FlatButton(
                  child: Text(
                    'Berikutnya',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17.0
                    ),
                  ),
                  color: Colors.white,
                  onPressed: (){
                    PengaturanAwalPage.of(context).berikutnya();
                  }
                )
              ]
            );
          }
          else if(snapshot.connectionState == ConnectionState.waiting)
          {
            return Center(
              child: CircularProgressIndicator()
            );
          }
        }
      )
    );
  }
}
