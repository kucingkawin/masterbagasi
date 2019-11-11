import 'package:flutter/material.dart';
import 'package:masterbagasi/indikator_bar.dart';
import 'package:masterbagasi/transaksi/proses_transaksi.dart';

class Pengiriman extends StatefulWidget {
  Pengiriman({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _PengirimanState createState() => _PengirimanState();
}

class _PengirimanState extends State<Pengiriman> {

  @override
  void initState()
  {
    super.initState();
  }

  Widget _cardPantauPengiriman()
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
                  'Pantau Pengiriman',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 5),
                Text(
                  'Pantau untuk melihat sudah sampai mana pengiriman itu berlangsung.',
                ),
              ]
            ),
          ),
          SizedBox(height: 8.0),
          ListTile(
            leading: CircleAvatar(radius: 20.0, backgroundColor: Colors.green),
            title: Text('Pembelian',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Dalam proses pembelian barang.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
          ListTile(
            leading: CircleAvatar(radius: 20.0, backgroundColor: Colors.amber),
            title: Text('Pengemasan',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Dalam proses pengemasan barang.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
          ListTile(
            leading: CircleAvatar(radius: 20.0, backgroundColor: Colors.grey[300]),
            title: Text('Pengiriman',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Barang sedang dalam perjalanan.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
          SizedBox(height: 8.0),
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
        Expanded(
          child: ListView(
            controller: ScrollController(),
            children: <Widget>[
              _cardPantauPengiriman(),
            ],
          )
        )
      ]
    );
  }
}