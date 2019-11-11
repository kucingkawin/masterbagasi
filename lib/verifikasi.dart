import 'package:flutter/material.dart';
import 'package:masterbagasi/pengaturan_awal/pengaturan_awal.dart';

class VerifikasiPage extends StatefulWidget {
  VerifikasiPage({Key key, this.title}) : super(key: key);

  static String route = 'verifikasi';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _VerifikasiPageState createState() => _VerifikasiPageState();
}

class _VerifikasiPageState extends State<VerifikasiPage> {

  TextEditingController _controllerVerifikasi = TextEditingController();

  Widget _fieldVerifikasi()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Kode verifikasi sudah dikirimkan lewat email. Masukan kode verifikasi.',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5.0),
        TextField(
          controller: _controllerVerifikasi,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Kode verifikasi.',
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            alignLabelWithHint: true,
          ),
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(title: Text('Verifikasi')),
      body: Center(
        child: Scrollbar(
          child: ListView(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            shrinkWrap: false,
            children: <Widget>[
              _fieldVerifikasi(),
              SizedBox(height: 15.0),
              FlatButton(
                child: Text('Verifikasi'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(PengaturanAwalPage.route);
                },
              ),
              SizedBox(height: 20.0),
              Text(
                'Jika ternyata belum dikirim, tekan tombol kirim untuk melakukan pengiriman ulang.',
              ),
              SizedBox(height: 15.0),
              FlatButton(
                child: Text('Kirim Ulang'),
                color: Colors.amber,
                textColor: Colors.white,
                onPressed: (){
                  Navigator.of(context).pushReplacementNamed(PengaturanAwalPage.route);
                },
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
