import 'package:flutter/material.dart';
import 'package:masterbagasi/frog_color.dart';
import 'package:masterbagasi/indikator_bar.dart';
import 'package:masterbagasi/indikator_proses.dart';
import 'package:masterbagasi/transaksi/proses_transaksi.dart';

class Negosiasi extends StatefulWidget {
  Negosiasi({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _NegosiasiState createState() => _NegosiasiState();
}

class _NegosiasiState extends State<Negosiasi> {

  @override
  void initState()
  {
    super.initState();
  }

  _cardLakukanNegosiasi()
  {
    return Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Lakukan Negosiasi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 5),
                Text(
                  'Untuk mencapai sebuah kesepakatan harus adanya suatu proses negosiasi. Proses negosiasi bisa dilakukan dengan beberapa cara diantaranya.',
                ),
              ]
            ),
          ),
          ListTile(
            leading: Icon(Icons.chat_bubble, size: 50.0),
            title: Text('Chat',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Lakukan chat untuk melakukan negosiasi.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          ),
        ]
      )
    );
  }

  Widget _cardKesepakatan(double normalisasi, ProsesTransaksiPageState prosesTransaksiPageState)
  {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Kesepakatan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 5),
                Text(
                  'Sesudah mencapai kesepakatan, tekan tombol setuju.',
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      'Setuju',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    color: Color.lerp(Colors.blue, Colors.green, normalisasi),
                    onPressed: (){
                      prosesTransaksiPageState.setState((){
                        prosesTransaksiPageState.nilaiPersetujuanNegosiasi += 1;
                        if(prosesTransaksiPageState.nilaiPersetujuanNegosiasi >= prosesTransaksiPageState.maxNilaiPersetujuanNegosiasi)
                        {
                          prosesTransaksiPageState.nilaiPersetujuanNegosiasi = prosesTransaksiPageState.maxNilaiPersetujuanNegosiasi;
                          prosesTransaksiPageState.indeksProses += 1;
                        }
                      });
                    },
                  )
                ),
              ]
            ),
          ),
        ]
      )
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
    ProsesTransaksiPageState prosesTransaksiPageState = ProsesTransaksiPage.of(context);
    double normalisasi = prosesTransaksiPageState.nilaiPersetujuanNegosiasi / prosesTransaksiPageState.maxNilaiPersetujuanNegosiasi;

    return Column(
      children: <Widget>[
        IndikatorBar(
          warna: Color.lerp(Colors.blue, Colors.green, normalisasi),
          value: normalisasi,
          minValue: 0.0,
          maxValue: 1.0
        ),
        Expanded(
          child: ListView(
            controller: ScrollController(),
            children: <Widget>[
              _cardLakukanNegosiasi(),
              _cardKesepakatan(normalisasi, prosesTransaksiPageState)
            ],
          )
        )
      ]
    );
  }
}